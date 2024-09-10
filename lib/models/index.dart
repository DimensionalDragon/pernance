// import 'dart:io';

import 'package:realm/realm.dart';

import 'package:pernance/models/subtransaction.dart';
import 'package:pernance/models/transaction.dart';
import 'package:pernance/models/category.dart';

import 'package:pernance/env/env.dart';
import 'package:pernance/utils/is_online.dart';

// var config = Configuration.local([
//   FinancialTransaction.schema,
//   FinancialSubtransaction.schema,
//   Category.schema,
// ]);
// var realm = Realm(config);

class RealmProvider {
  static final RealmProvider _instance = RealmProvider._internal();
  late Realm _realm;

  factory RealmProvider() {
    return _instance;
  }

  RealmProvider._internal();

  // void _writeInitialData() {
  //   _realm.write(() {
      
  //   });
  // }

  Future<void> initializeRealm(String firebaseToken) async {
    final app = App(AppConfiguration(Env.realmAppID));
    
    final jwtCredentials = Credentials.jwt(firebaseToken);
    final currentUser = await app.logIn(jwtCredentials);

    final config = Configuration.flexibleSync(currentUser, [
      FinancialTransaction.schema,
      FinancialSubtransaction.schema,
      Category.schema,
    ]);

    // If offline, open local realm instead, sync it later
    if (await isOnline()) {
      _realm = await Realm.open(config);
      // _writeInitialData();
    } else {
      _realm = Realm(config);
      // _writeInitialData();
    }

    // Sync update configuration
    // realm.subscriptions.update((mutableSubscriptions) {
    //   mutableSubscriptions.add(realm.query<Category>(r'name == $0 AND age > $1', ['Clifford', 5]));
    // });
    // await realm.subscriptions.waitForSynchronization();
  }

  Realm get realm => _realm;
}
