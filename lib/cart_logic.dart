import 'package:flutter/material.dart';
import 'product.dart';

class CartLogic extends ChangeNotifier {
  final Map<Product, int> _cartItems = {}; // Cart items with quantities
  final List<Product> _wishlist = []; // Wishlist items

  Map<Product, int> get cartItems => _cartItems;
  List<Product> get wishlist => _wishlist;

  // Cart Methods
  void toggleProductInCart(Product item) {
    if (_cartItems.containsKey(item)) {
      removeFromCart(item);
    } else {
      addToCart(item);
    }
  }

  void addToCart(Product item) {
    if (_cartItems.containsKey(item)) {
      _cartItems[item] = _cartItems[item]! + 1; // Increment quantity
    } else {
      _cartItems[item] = 1; // Add item with quantity 1
    }
    notifyListeners();
  }

  void removeFromCart(Product item) {
    _cartItems.remove(item); // Remove item completely
    notifyListeners();
  }

  void incrementQuantity(Product item) {
    if (_cartItems.containsKey(item)) {
      _cartItems[item] = _cartItems[item]! + 1; // Increment quantity
      notifyListeners();
    }
  }

  void decrementQuantity(Product item) {
    if (_cartItems.containsKey(item) && _cartItems[item]! > 1) {
      _cartItems[item] = _cartItems[item]! - 1; // Decrement quantity
    } else {
      removeFromCart(item); // Remove item if quantity is 1
    }
    notifyListeners();
  }

  double calculateTotalAmount() {
    double total = 0.0;
    _cartItems.forEach((product, quantity) {
      total += product.price * quantity; // Calculate total based on quantity
    });
    return total;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int get numOfCartItems => _cartItems.length; // Number of unique products

  int get numOfItems {
    // Calculate the total number of items based on quantities
    return _cartItems.values.fold(0, (total, quantity) => total + quantity);
  }

  // Wishlist Methods
  void toggleProductInWishlist(Product item) {
    if (isProductInWishlist(item)) {
      removeFromWishlist(item);
    } else {
      addToWishlist(item);
    }
  }

  void addToWishlist(Product item) {
    if (!isProductInWishlist(item)) {
      _wishlist.add(item);
      notifyListeners();
    }
  }

  void removeFromWishlist(Product item) {
    _wishlist.removeWhere((wishlistItem) => wishlistItem.id == item.id);
    notifyListeners();
  }

  bool isProductInWishlist(Product item) {
    return _wishlist.any((wishlistItem) => wishlistItem.id == item.id);
  }

  int get numOfWishlistItems => _wishlist.length;

  void clearWishlist() {
    _wishlist.clear();
    notifyListeners();
  }
}
