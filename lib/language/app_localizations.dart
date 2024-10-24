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
      'allCategory': 'All',
      'electronicsCategory': 'Electronics',
      'jeweleryCategory': 'Jewelery',
      'mensClothingCategory': 'Men\'s Clothing',
      'womensClothingCategory': 'Women\'s Clothing',
      'noneSort': 'Default',
      'lowestToHighestSort': 'Lowest to Highest',
      'highestToLowestSort': 'Highest to Lowest',
      'profile': 'Profile',
      'signOut': 'Sign Out',
      'theme': 'Theme',
      'systemTheme': 'System',
      'lightTheme': 'Light',
      'darkTheme': 'Dark',
      'home': 'Home',
      'aboutUs': 'About Us',
    },
    'zh': {
      'appTitle': '威米商城',
      'searchHint': '搜索产品...',
      'sortByPrice': '按价格排序：',
      'recommendedForYou': '为您推荐',
      'allProducts': '所有产品',
      'addProduct': '添加产品',
      'language': '语言',
      'allCategory': '所有',
      'electronicsCategory': '电子产品',
      'jeweleryCategory': '珠宝',
      'mensClothingCategory': '男装',
      'womensClothingCategory': '女装',
      'noneSort': '默认',
      'lowestToHighestSort': '从低到高',
      'highestToLowestSort': '从高到低',
      'profile': '个人资料',
      'signOut': '登出',
      'theme': '主题',
      'systemTheme': '系统',
      'lightTheme': '浅色',
      'darkTheme': '深色',
      'home': '主页',
      'aboutUs': '关于我们',
    },
    'km': {
      'appTitle': 'Vmerce ទំព័រដើម',
      'searchHint': 'ស្វែងរក...',
      'sortByPrice': 'តម្រៀបតាមតម្លៃ',
      'recommendedForYou': 'ណែនាំសម្រាប់អ្នក',
      'allProducts': 'ផលិតផលទាំងអស់',
      'addProduct': 'បន្ថែមផលិតផល',
      'language': 'ភាសា',
      'allCategory': 'ទាំងអស់',
      'electronicsCategory': 'អេឡិចត្រូនិច',
      'jeweleryCategory': 'គ្រឿងអលង្ការ',
      'mensClothingCategory': 'សម្លៀកបំពាក់បុរស',
      'womensClothingCategory': 'សម្លៀកបំពាក់ស្ត្រី',
      'noneSort': 'លំនាំដើម',
      'lowestToHighestSort': 'ពីតម្លៃទាបទៅខ្ពស់',
      'highestToLowestSort': 'ពីតម្លៃខ្ពស់ទៅទាប',
      'profile': 'ប្រវត្តិរូប',
      'signOut': 'ចាកចេញ',
      'theme': 'ស្បែក',
      'systemTheme': 'ប្រព័ន្ធ',
      'lightTheme': 'ភ្លឺ',
      'darkTheme': 'ងងឹត',
      'home': 'ទំព័រដើម',
      'aboutUs': 'អំពីយើង',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get searchHint => _localizedValues[locale.languageCode]!['searchHint']!;
  String get sortByPrice => _localizedValues[locale.languageCode]!['sortByPrice']!;
  String get recommendedForYou => _localizedValues[locale.languageCode]!['recommendedForYou']!;
  String get allProducts => _localizedValues[locale.languageCode]!['allProducts']!;
  String get addProduct => _localizedValues[locale.languageCode]!['addProduct']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get allCategory => _localizedValues[locale.languageCode]!['allCategory']!;
  String get electronicsCategory => _localizedValues[locale.languageCode]!['electronicsCategory']!;
  String get jeweleryCategory => _localizedValues[locale.languageCode]!['jeweleryCategory']!;
  String get mensClothingCategory => _localizedValues[locale.languageCode]!['mensClothingCategory']!;
  String get womensClothingCategory => _localizedValues[locale.languageCode]!['womensClothingCategory']!;
  String get noneSort => _localizedValues[locale.languageCode]!['noneSort']!;
  String get lowestToHighestSort => _localizedValues[locale.languageCode]!['lowestToHighestSort']!;
  String get highestToLowestSort => _localizedValues[locale.languageCode]!['highestToLowestSort']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get signOut => _localizedValues[locale.languageCode]!['signOut']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get systemTheme => _localizedValues[locale.languageCode]!['systemTheme']!;
  String get lightTheme => _localizedValues[locale.languageCode]!['lightTheme']!;
  String get darkTheme => _localizedValues[locale.languageCode]!['darkTheme']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get aboutUs => _localizedValues[locale.languageCode]!['aboutUs']!;
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
