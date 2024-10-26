import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
      'profileUpdated': 'Profile updated successfully',
      'profileUpdateFailed': 'Failed to update profile',
      'fillPasswordFields':
          'Please fill in both password fields to change your password.',
      'passwordUpdated': 'Password updated successfully',
      'passwordUpdateFailed': 'Failed to update password',
      'name': 'Name',
      'nameCannotBeEmpty': 'Name cannot be empty',
      'email': 'Email',
      'saveProfile': 'Save Profile',
      'changePassword': 'Change Password',
      'oldPassword': 'Old Password',
      'newPassword': 'New Password',
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
      'profileUpdated': '个人资料更新成功',
      'profileUpdateFailed': '更新个人资料失败',
      'fillPasswordFields': '请填写两个密码字段以更改密码。',
      'passwordUpdated': '密码更新成功',
      'passwordUpdateFailed': '更新密码失败',
      'name': '姓名',
      'nameCannotBeEmpty': '姓名不能为空',
      'email': '电子邮件',
      'saveProfile': '保存个人资料',
      'changePassword': '更改密码',
      'oldPassword': '旧密码',
      'newPassword': '新密码',
      'cartTitle': 'Cart',
      'wishlistTitle': 'Wishlist',
      'orderHistoryTitle': 'Order History',
      'addedToCart': 'added to cart!',
      'loginToViewOrders': 'Please log in to view your order history.',
      'error': 'Error',
      'noOrdersFound': 'No orders found.',
      'cartTitle': '购物车',
      'wishlistTitle': '愿望清单',
      'orderHistoryTitle': '订单历史',
      'addedToCart': '已加入购物车！',
      'loginToViewOrders': '请登录以查看您的订单历史。',
      'error': '错误',
      'noOrdersFound': '未找到订单。',
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
      'profileUpdated': 'ប្រវត្តិរូបបានធ្វើបច្ចុប្បន្នភាពដោយជោគជ័យ',
      'profileUpdateFailed': 'បរាជ័យក្នុងការធ្វើបច្ចុប្បន្នភាពប្រវត្តិរូប',
      'fillPasswordFields':
          'សូមបំពេញវាលពាក្យសម្ងាត់ទាំងពីរដើម្បីផ្លាស់ប្តូរពាក្យសម្ងាត់របស់អ្នក។',
      'passwordUpdated': 'ពាក្យសម្ងាត់បានធ្វើបច្ចុប្បន្នភាពដោយជោគជ័យ',
      'passwordUpdateFailed': 'បរាជ័យក្នុងការធ្វើបច្ចុប្បន្នភាពពាក្យសម្ងាត់',
      'name': 'ឈ្មោះ',
      'nameCannotBeEmpty': 'ឈ្មោះមិនអាចទទេ',
      'email': 'អ៊ីមែល',
      'saveProfile': 'រក្សាទុកប្រវត្តិរូប',
      'changePassword': 'ផ្លាស់ប្តូរពាក្យសម្ងាត់',
      'oldPassword': 'ពាក្យសម្ងាត់ចាស់',
      'newPassword': 'ពាក្យសម្ងាត់ថ្មី',
      'cartTitle': 'រទេះ',
      'wishlistTitle': 'បញ្ជីបំណង',
      'orderHistoryTitle': 'ប្រវត្តិការបញ្ជាទិញ',
      'addedToCart': 'បានបន្ថែមទៅរទេះ!',
      'loginToViewOrders': 'សូមចូលដើម្បីមើលប្រវត្តិការបញ្ជាទិញរបស់អ្នក។',
      'error': 'កំហុស',
      'noOrdersFound': 'រកមិនឃើញការបញ្ជាទិញទេ។',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get searchHint =>
      _localizedValues[locale.languageCode]!['searchHint']!;
  String get sortByPrice =>
      _localizedValues[locale.languageCode]!['sortByPrice']!;
  String get recommendedForYou =>
      _localizedValues[locale.languageCode]!['recommendedForYou']!;
  String get allProducts =>
      _localizedValues[locale.languageCode]!['allProducts']!;
  String get addProduct =>
      _localizedValues[locale.languageCode]!['addProduct']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get allCategory =>
      _localizedValues[locale.languageCode]!['allCategory']!;
  String get electronicsCategory =>
      _localizedValues[locale.languageCode]!['electronicsCategory']!;
  String get jeweleryCategory =>
      _localizedValues[locale.languageCode]!['jeweleryCategory']!;
  String get mensClothingCategory =>
      _localizedValues[locale.languageCode]!['mensClothingCategory']!;
  String get womensClothingCategory =>
      _localizedValues[locale.languageCode]!['womensClothingCategory']!;
  String get noneSort => _localizedValues[locale.languageCode]!['noneSort']!;
  String get lowestToHighestSort =>
      _localizedValues[locale.languageCode]!['lowestToHighestSort']!;
  String get highestToLowestSort =>
      _localizedValues[locale.languageCode]!['highestToLowestSort']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get signOut => _localizedValues[locale.languageCode]!['signOut']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get systemTheme =>
      _localizedValues[locale.languageCode]!['systemTheme']!;
  String get lightTheme =>
      _localizedValues[locale.languageCode]!['lightTheme']!;
  String get darkTheme => _localizedValues[locale.languageCode]!['darkTheme']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get aboutUs => _localizedValues[locale.languageCode]!['aboutUs']!;
  String get profileUpdated =>
      _localizedValues[locale.languageCode]!['profileUpdated']!;
  String get profileUpdateFailed =>
      _localizedValues[locale.languageCode]!['profileUpdateFailed']!;
  String get fillPasswordFields =>
      _localizedValues[locale.languageCode]!['fillPasswordFields']!;
  String get passwordUpdated =>
      _localizedValues[locale.languageCode]!['passwordUpdated']!;
  String get passwordUpdateFailed =>
      _localizedValues[locale.languageCode]!['passwordUpdateFailed']!;
  String get name => _localizedValues[locale.languageCode]!['name']!;
  String get nameCannotBeEmpty =>
      _localizedValues[locale.languageCode]!['nameCannotBeEmpty']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get saveProfile =>
      _localizedValues[locale.languageCode]!['saveProfile']!;
  String get changePassword =>
      _localizedValues[locale.languageCode]!['changePassword']!;
  String get oldPassword =>
      _localizedValues[locale.languageCode]!['oldPassword']!;
  String get newPassword =>
      _localizedValues[locale.languageCode]!['newPassword']!;

  String get cartTitle => _localizedValues[locale.languageCode]!['cartTitle']!;
  String get wishlistTitle =>
      _localizedValues[locale.languageCode]!['wishlistTitle']!;
  String get orderHistoryTitle =>
      _localizedValues[locale.languageCode]!['orderHistoryTitle']!;
  String get addedToCart =>
      _localizedValues[locale.languageCode]!['addedToCart']!;
  String get loginToViewOrders =>
      _localizedValues[locale.languageCode]!['loginToViewOrders']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get noOrdersFound =>
      _localizedValues[locale.languageCode]!['noOrdersFound']!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'zh', 'km'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
