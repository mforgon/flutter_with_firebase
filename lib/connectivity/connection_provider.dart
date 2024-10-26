import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isOnline = true;
  bool get isOnline => _isOnline;
  
  StreamSubscription? connectivitySubscription;
  
  ConnectivityProvider() {
    _initializeConnectivity();
    _subscribeToConnectivityChanges();
  }
  
  Future<void> _initializeConnectivity() async {
    try {
      ConnectivityResult result = await Connectivity().checkConnectivity();
      _isOnline = result != ConnectivityResult.none;
      notifyListeners();
    } catch (e) {
      print('Error checking initial connectivity: $e');
    }
  }
  
  void _subscribeToConnectivityChanges() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _isOnline = result != ConnectivityResult.none;
      notifyListeners();
      print('Connectivity changed: $_isOnline');
    });
  }

  Future<void> checkConnectivity() async {
    try {
      ConnectivityResult result = await Connectivity().checkConnectivity();
      _isOnline = result != ConnectivityResult.none;
      notifyListeners();
    } catch (e) {
      print('Error checking connectivity: $e');
    }
  }
  
  @override
  void dispose() {
    connectivitySubscription?.cancel();
    super.dispose();
  }
}
