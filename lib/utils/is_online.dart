import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isOnline() async {
  List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

  if(connectivityResult.contains(ConnectivityResult.mobile)) {
    return true;
  } else if(connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  }
  return false;
}