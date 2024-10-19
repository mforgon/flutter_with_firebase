import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  final List<Product> _wishlist = [];

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  List<Product> get wishlist => _wishlist;

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
