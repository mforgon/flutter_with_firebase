import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_service.dart';
import 'language/app_localizations.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<Product> _wishlist = [];
  // final List<String> _categories = ['All', 'Electronics', 'Jewelery', 'Men\'s Clothing', 'Women\'s Clothing'];
  String _selectedCategory = 'All';
  String _priceSort = 'Default';

  // Cache for localized categories
  Map<String, String> _categoryMappings = {};

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  List<Product> get wishlist => _wishlist;
  // List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  String get priceSort => _priceSort;
// Get categories in the current language
  List<String> getCategories(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    // Update category mappings for the current language
    _categoryMappings = {
      localizations.allCategory.toLowerCase(): 'all',
      localizations.electronicsCategory.toLowerCase(): 'electronics',
      localizations.jeweleryCategory.toLowerCase(): 'jewelery',
      localizations.mensClothingCategory.toLowerCase(): "men's clothing",
      localizations.womensClothingCategory.toLowerCase(): "women's clothing",
    };

    return [
      localizations.allCategory,
      localizations.electronicsCategory,
      localizations.jeweleryCategory,
      localizations.mensClothingCategory,
      localizations.womensClothingCategory,
    ];
  }


  ProductProvider() {
    _firestoreService.getProducts().listen(_updateProducts);
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _firestoreService.getWishlist(user.uid).listen((wishlist) {
          _wishlist = wishlist;
          notifyListeners();
        });
      }
    });
  }

  void _updateProducts(List<Product> products) {
    _products = products;
    _filteredProducts = products;
    notifyListeners();
  }

  void addToWishlist(Product product) {
    final user = _auth.currentUser;
    if (user != null && !_wishlist.any((p) => p.id == product.id)) {
      _firestoreService.addToWishlist(user.uid, product);
    }
  }

  void removeFromWishlist(String productId) {
    final user = _auth.currentUser;
    if (user != null) {
      _firestoreService.removeFromWishlist(user.uid, productId);
    }
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

 // Get the standardized category value from a localized category name
  String _getStandardCategory(String localizedCategory) {
    return _categoryMappings[localizedCategory.toLowerCase()] ?? localizedCategory;
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    filterProductsByCategory(category);
  }

  void filterProductsByCategory(String localizedCategory) {
    final standardCategory = _getStandardCategory(localizedCategory);
    
    if (standardCategory.toLowerCase() == 'all') {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products.where((product) {
        // Convert product category to standard format for comparison
        return product.category.toLowerCase() == standardCategory.toLowerCase();
      }).toList();
    }
    notifyListeners();
  }

  void setPriceSort(String sortOption) {
    _priceSort = sortOption;
    if (sortOption == 'Default') {
      _filteredProducts = _products;
    } else if (sortOption == 'Lowest to Highest') {
      sortProductsByPrice(true);
    } else if (sortOption == 'Highest to Lowest') {
      sortProductsByPrice(false);
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
    try {
      await _firestoreService.addProduct(product);
    } catch (e) {
      // Handle error, e.g., log it or show a message to the user
      print('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _firestoreService.updateProduct(product);
    } catch (e) {
      // Handle error
      print('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _firestoreService.deleteProduct(id);
    } catch (e) {
      // Handle error
      print('Error deleting product: $e');
    }
  }
}
