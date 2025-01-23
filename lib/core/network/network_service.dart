import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.first == ConnectivityResult.wifi ||
        connectivityResult.first == ConnectivityResult.ethernet ||
        connectivityResult.first == ConnectivityResult.mobile;
  }
}
