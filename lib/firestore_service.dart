import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/fake_product_model.dart';
import 'package:flutter_with_firebase/product_review.dart';
import 'order_model.dart' as model;
import 'product.dart';
import 'package:http/http.dart' as http;

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> fetchAndSaveProductsFromApi() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> productsJson = jsonDecode(response.body);
      for (var productJson in productsJson) {
        final fakeProduct = FakeProduct.fromJson(productJson);
        final product = Product.fromFakeProduct(fakeProduct);
        await addProduct(product);
      }
    } else {
      throw Exception('Failed to load products from API');
    }
  }

  Stream<List<model.Order>> getOrders(String userId) {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            try {
              return model.Order.fromFirestore(doc);
            } catch (e) {
              print('Error converting document: $e');
              return null;
            }
          })
          .where((order) => order != null)
          .cast<model.Order>()
          .toList();
    });
  }

  Future<void> addOrder(model.Order order) {
    return _db.collection('orders').add(order.toMap());
  }

  Stream<List<Review>> getReviews(String productId) {
    return _db
        .collection('products')
        .doc(productId)
        .collection('reviews')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList());
  }

  Future<void> addReview(String productId, Review review) {
    if (productId.isEmpty) {
      throw ArgumentError('Product ID cannot be empty');
    }
    return _db
        .collection('products')
        .doc(productId)
        .collection('reviews')
        .add(review.toMap());
  }

  Future<void> addProduct(Product product) {
    return _db.collection('products').add(product.toMap());
  }

  Future<void> updateProduct(Product product) {
    return _db.collection('products').doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(String id) {
    return _db.collection('products').doc(id).delete();
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
  }

  /// Adds a product to the user's wishlist in Firestore
  Future<void> addToWishlist(String userId, Product product) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(product.id)
          .set({
        'name': product.name,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'category': product.category,
        'description': product.description,
      });
    } catch (e) {
      print('Error adding to wishlist: $e');
    }
  }

  /// Removes a product from the user's wishlist
  Future<void> removeFromWishlist(String userId, String productId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(productId)
          .delete();
    } catch (e) {
      print('Error removing from wishlist: $e');
    }
  }

  /// Fetches the user's wishlist as a stream
  Stream<List<Product>> getWishlist(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
  }
}
