import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeProvider extends ChangeNotifier {
  final _storage = FlutterSecureStorage();
  int _themeIndex = 0; // 0: System, 1: Light, 2: Dark

  int get themeIndex => _themeIndex;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    String? themeIndexStr = await _storage.read(key: 'themeIndex');
    _themeIndex = themeIndexStr != null ? int.parse(themeIndexStr) : 0;
    notifyListeners();
  }

  Future<void> setTheme(int index) async {
    _themeIndex = index;
    await _storage.write(key: 'themeIndex', value: index.toString());
    notifyListeners();
  }
}
