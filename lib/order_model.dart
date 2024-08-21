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
      userId: data['userId'] ?? '',
      products: (data['products'] as List)
          .map((item) => Product.fromMap(item as Map<String, dynamic>, ''))
          .toList(),
      totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
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
