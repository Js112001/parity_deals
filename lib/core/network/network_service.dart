import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deals/core/di/injection_container.dart';

class NetworkService {
  Future<bool> isConnected() async {
    final connectivityResult = await sl<Connectivity>().checkConnectivity();
    return connectivityResult.first == ConnectivityResult.wifi ||
        connectivityResult.first == ConnectivityResult.ethernet ||
        connectivityResult.first == ConnectivityResult.mobile;
  }
}
