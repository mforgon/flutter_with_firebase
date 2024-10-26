import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isOnline = true;
  bool get isOnline => _isOnline;
  
  StreamSubscription? connectivitySubscription;
  
  ConnectivityProvider() {
    checkConnectivity();
  }
  
  void checkConnectivity() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _isOnline = result != ConnectivityResult.none;
      notifyListeners();
    });
  }
  
  @override
  void dispose() {
    connectivitySubscription?.cancel();
    super.dispose();
  }
}