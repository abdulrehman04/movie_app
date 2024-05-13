import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityService {
  Stream<ConnectivityResult> getConnectivityStream() {
    return Connectivity().onConnectivityChanged;
  }
}
