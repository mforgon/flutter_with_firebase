import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageProvider with ChangeNotifier {
  final _storage = FlutterSecureStorage();
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LanguageProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    String? languageCode = await _storage.read(key: 'languageCode');
    if (languageCode != null && ['en', 'zh', 'km'].contains(languageCode)) {
      _locale = Locale(languageCode);
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (!['en', 'zh', 'km'].contains(locale.languageCode)) return;
    if (_locale != locale) {
      _locale = locale;
      await _storage.write(key: 'languageCode', value: locale.languageCode);
      notifyListeners();
    }
  }
}
