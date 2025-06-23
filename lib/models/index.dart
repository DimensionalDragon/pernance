import 'package:pernance/env/env.dart';
import 'package:pernance/models/error_codes.dart';
import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:pernance/models/category.dart';
import 'package:pernance/models/transaction.dart';
import 'package:pernance/models/subtransaction.dart';

late final PowerSyncDatabase db;

Future<String> getDatabasePath() async {
  final dir = await getApplicationSupportDirectory();
  return join(dir.path, 'pernance_store.db');
}

bool isLoggedIn() {
  return Supabase.instance.client.auth.currentSession?.accessToken != null;
}

Future<void> openDatabase() async {
  const schema = Schema([categorySchema, transactionSchema, subtransactionSchema]);

  db = PowerSyncDatabase(schema: schema, path: await getDatabasePath());
  await db.initialize();

  await Supabase.initialize(url: Env.supabaseProjectURL, anonKey: Env.supabaseAPIKey);

  SupabaseConnector? currentConnector;
  print(Env.supabaseAPIKey);
  print(Env.supabaseProjectURL);

  if (isLoggedIn()) {
    // This will run when first opening the app
    currentConnector = SupabaseConnector(db);
    await db.connect(connector: currentConnector);
  }

  Supabase.instance.client.auth.onAuthStateChange.listen((AuthState data) async {
    AuthChangeEvent event = data.event;
    if (event == AuthChangeEvent.signedIn) {
      currentConnector = SupabaseConnector(db);
      await db.connect(connector: currentConnector!);
    } else if (event == AuthChangeEvent.signedOut) {
      currentConnector = null;
      await db.disconnect();
    } else if (event == AuthChangeEvent.tokenRefreshed) {
      currentConnector?.prefetchCredentials();
    }
  });
}

class SupabaseConnector extends PowerSyncBackendConnector {
  
  SupabaseConnector(this.db);

  PowerSyncDatabase db;

  @override
  Future<void> uploadData(PowerSyncDatabase database) async {
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) {
      return;
    }

    final rest = Supabase.instance.client.rest;
    try {
      for (var op in transaction.crud) {
        final table = rest.from(op.table);
        if (op.op == UpdateType.put) {
          var data = Map<String, dynamic>.of(op.opData!);
          data['id'] = op.id;
          await table.upsert(data);
        } else if (op.op == UpdateType.patch) {
          await table.update(op.opData!).eq('id', op.id);
        } else if (op.op == UpdateType.delete) {
          await table.delete().eq('id', op.id);
        }
      }

      await transaction.complete();
    } on PostgrestException catch (e) {
      if (e.code != null && fatalResponseCodes.any((re) => re.hasMatch(e.code!))) {
        await transaction.complete();
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      return null;
    }
    return PowerSyncCredentials(endpoint: Env.powersyncInstanceURL, token: session.accessToken);
  }
}