import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  final List<Product> _wishlist = [];
  final List<String> _categories = ['All', 'Electronics', 'Jewelery', 'Men\'s Clothing', 'Women\'s Clothing'];
  String _selectedCategory = 'All';
  String _priceSort = 'Default';

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  List<Product> get wishlist => _wishlist;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  String get priceSort => _priceSort;

  ProductProvider() {
    _firestoreService.getProducts().listen(_updateProducts);
  }

  void _updateProducts(List<Product> products) {
    _products = products;
    _filteredProducts = products;
    notifyListeners();
  }

  void addToWishlist(Product product) {
    _wishlist.add(product);
    notifyListeners();
  }

  void removeFromWishlist(String productId) {
    _wishlist.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    filterProductsByCategory(category);
  }

  void setPriceSort(String sortOption) {
    _priceSort = sortOption;
    if (sortOption == 'Lowest to Highest') {
      sortProductsByPrice(true);
    } else if (sortOption == 'Highest to Lowest') {
      sortProductsByPrice(false);
    }
  }

  void filterProductsByCategory(String category) {
    if (category == 'All') {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products.where((product) => product.category == category.toLowerCase()).toList();
    }
    notifyListeners();
  }

  List<Product> getRecommendedProducts() {
    List<Product> recommendations = [];
    Set<String> usedCategories = {};

    List<Product> productsToRecommend = _filteredProducts.isNotEmpty ? _filteredProducts : _products;
    List<Product> shuffledProducts = List.from(productsToRecommend)..shuffle();

    for (Product product in shuffledProducts) {
      if (!usedCategories.contains(product.category)) {
        recommendations.add(product);
        usedCategories.add(product.category);
      }

      if (recommendations.length == 5 || recommendations.length == productsToRecommend.length) {
        break;
      }
    }

    return recommendations;
  }

  void sortProductsByPrice(bool ascending) {
    _filteredProducts.sort((a, b) => ascending
        ? a.price.compareTo(b.price)
        : b.price.compareTo(a.price));
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _firestoreService.addProduct(product);
  }

  Future<void> updateProduct(Product product) async {
    await _firestoreService.updateProduct(product);
  }

  Future<void> deleteProduct(String id) async {
    await _firestoreService.deleteProduct(id);
  }
}
