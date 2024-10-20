import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Vmerce Home',
      'searchHint': 'Search...',
      'sortByPrice': 'Sort by Price',
      'recommendedForYou': 'Recommended for You',
      'allProducts': 'All Products',
      'addProduct': 'Add Product',
      'language': 'Language',
    },
    'zh': {
      'appTitle': '威米商城',
      'searchHint': '搜索产品...',
      'sortByPrice': '按价格排序：',
      'recommendedForYou': '为您推荐',
      'allProducts': '所有产品',
      'addProduct': '添加产品',
      'language': '语言',
    },
    'km': {
      'appTitle': 'Vmerce ទំព័រដើម',
      'searchHint': 'ស្វែងរក...',
      'sortByPrice': 'តម្រៀបតាមតម្លៃ',
      'recommendedForYou': 'ណែនាំសម្រាប់អ្នក',
      'allProducts': 'ផលិតផលទាំងអស់',
      'addProduct': 'បន្ថែមផលិតផល',
      'language': 'ភាសា',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get searchHint => _localizedValues[locale.languageCode]!['searchHint']!;
  String get sortByPrice => _localizedValues[locale.languageCode]!['sortByPrice']!;
  String get recommendedForYou => _localizedValues[locale.languageCode]!['recommendedForYou']!;
  String get allProducts => _localizedValues[locale.languageCode]!['allProducts']!;
  String get addProduct => _localizedValues[locale.languageCode]!['addProduct']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh', 'km'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}