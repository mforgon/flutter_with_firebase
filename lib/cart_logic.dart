import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/product.dart';

class CartLogic extends ChangeNotifier {
  List<Product> _cartList = [];

  List<Product> get cartList => _cartList;

  void toggleProductInCart(Product item) {
    if (isProductInCart(item)) {
      removeFromCart(item);
    } else {
      addToCart(item);
    }
  }

  void addToCart(Product item) {
    _cartList.add(item);
    notifyListeners();
  }

  void removeFromCart(Product item) {
    _cartList.removeWhere((cartItem) => cartItem.id == item.id);
    notifyListeners();
  }

  bool isProductInCart(Product item) {
    return _cartList.any((cartItem) => cartItem.id == item.id);
  }

  int get numOfItems => _cartList.length;

  double calculateTotalAmount() {
    double total = 0.0;
    for (var product in _cartList) {
      total += product.price;
    }
    return total;
  }

  void clearCart() {
    _cartList.clear();
    notifyListeners();
  }
}
