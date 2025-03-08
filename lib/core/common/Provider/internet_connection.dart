import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
  (ref) => ConnectivityStatusNotifier(),
);

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatusNotifier() : super(ConnectivityStatus.notDetermined) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      final newState = _getConnectivityStatus(result);
      if (newState != state) {
        state = newState;
      }
    });
  }
//sasto-hotel
  ConnectivityStatus _getConnectivityStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      return ConnectivityStatus.isConnected;
    } else {
      return ConnectivityStatus.isDisconnected;
    }
  }
}
