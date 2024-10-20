import 'package:intl/intl.dart';

class MessageZh {
  static String get appTitle => Intl.message('威米商城', name: 'appTitle');
  static String get searchHint => Intl.message('搜索产品...', name: 'searchHint');
  static String get sortByPrice => Intl.message('按价格排序：', name: 'sortByPrice');
  static String get recommendedForYou => Intl.message('为您推荐', name: 'recommendedForYou');
  static String get allProducts => Intl.message('所有产品', name: 'allProducts');
  static String get addProduct => Intl.message('添加产品', name: 'addProduct');
  // Add more translations as needed
}
