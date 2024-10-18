import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<String?> getUserId() async {
  final session = Supabase.instance.client.auth.currentSession;
  if (session != null) {
    return session.user.id;
  } else {
    return null;
  }
}

Future<bool> isOnline() async {
  List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

  if(connectivityResult.contains(ConnectivityResult.mobile)) {
    return true;
  } else if(connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  }
  return false;
}