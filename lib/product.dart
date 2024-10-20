import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/fake_product_model.dart';

class Product {
  final String id; 
  final String name;
  final String imageUrl;
  final double price;
  final String description; 
  final String category;    

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description, 
    required this.category,    
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id, 
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      description: data['description'] ?? '', 
      category: data['category'] ?? '',        
    );
  }

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      description: data['description'] ?? '', 
      category: data['category'] ?? '',       
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'description': description, 
      'category': category,       
    };
  }

  factory Product.fromFakeProduct(FakeProduct fakeProduct) {
    return Product(
      id: fakeProduct.id.toString(),
      name: fakeProduct.title,
      imageUrl: fakeProduct.image,
      price: fakeProduct.price,
      description: fakeProduct.description,
      category: fakeProduct.category,
    );
  }
}
