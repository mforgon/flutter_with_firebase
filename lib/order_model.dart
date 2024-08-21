import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/product.dart';

class Order {
  final String id;
  final String userId;
  final List<Product> products;
  final double totalAmount;
  final DateTime date;

  Order({
    required this.id,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.date,
  });

  factory Order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Order(
      id: doc.id,
      userId: data['userId'],
      products: (data['products'] as List).map((item) => Product.fromFirestore(item)).toList(),
      totalAmount: data['totalAmount'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'products': products.map((product) => product.toMap()).toList(),
      'totalAmount': totalAmount,
      'date': date,
    };
  }
}
