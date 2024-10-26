import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/product.dart';

class CartLogic extends ChangeNotifier {
  List<Product> _cartList = [];
  List<Product> _wishlist = []; // Separate wishlist

  List<Product> get cartList => _cartList;
  List<Product> get wishlist => _wishlist;

  // Toggle product only in the Cart list
  void toggleProductInCart(Product item) {
    if (isProductInCart(item)) {
      removeFromCart(item);
    } else {
      addToCart(item);
    }
  }

  // Toggle product only in the Wishlist list
  void toggleProductInWishlist(Product item) {
    if (isProductInWishlist(item)) {
      removeFromWishlist(item);
    } else {
      addToWishlist(item);
    }
  }

  void addToCart(Product item) {
    if (!isProductInCart(item)) {
      _cartList.add(item);
      notifyListeners();
    }
  }

  void removeFromCart(Product item) {
    _cartList.removeWhere((cartItem) => cartItem.id == item.id);
    notifyListeners();
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

  bool isProductInCart(Product item) {
    return _cartList.any((cartItem) => cartItem.id == item.id);
  }

  bool isProductInWishlist(Product item) {
    return _wishlist.any((wishlistItem) => wishlistItem.id == item.id);
  }

  int get numOfCartItems => _cartList.length;

  double calculateTotalAmount() {
    double total = 0.0;
    for (var product in _cartList) {
      total += product.price;
    }
    return total;
  }

  int get numOfItems => _cartList.length;

  void clearCart() {
    _cartList.clear();
    notifyListeners();
  }
}
