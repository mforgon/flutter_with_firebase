import 'package:flutter/material.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
  Product(
    id: '1',
    name: 'Product 1',
    description: 'Description for product 1',
    price: 29.99,
    imageUrl: 'https://baconmockup.com/200/300',
  ),
  Product(
    id: '2',
    name: 'Product 2',
    description: 'Description for product 2',
    price: 49.99,
    imageUrl: 'https://loremflickr.com/200/300',
  ),
];

  List<Product> get products => [..._products];

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final index = _products.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _products[index] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
