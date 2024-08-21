import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/product_review.dart';
import 'order_model.dart' as model;
import 'product.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

Stream<List<model.Order>> getOrders(String userId) {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            try {
              return model.Order.fromFirestore(doc);
            } catch (e) {
              // Handle the error (e.g., log it)
              print('Error converting document: $e');
              return null; // or handle it in a way that suits your app
            }
          }).where((order) => order != null).cast<model.Order>().toList(); // Filter out nulls and cast to List<Order>
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


}
