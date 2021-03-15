import 'dart:async';

import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>.broadcast();

  void init() {
    ConnectivityResult lastResult;
    Timer.periodic(Duration(seconds: 5), (timer) async {
      if (lastResult == null)
        lastResult = await Connectivity().checkConnectivity();
      ConnectivityResult result = await Connectivity().checkConnectivity();

      if (result == lastResult) return;
      if (_getStatusFromResult(result) == ConnectivityStatus.Offline) {
        lastResult = result;
        connectionStatusController.add(_getStatusFromResult(result));
      } else {
        lastResult = result;
        connectionStatusController.add(_getStatusFromResult(result));
      }
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Online;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}

enum ConnectivityStatus { Online, Offline }
