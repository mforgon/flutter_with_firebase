// product_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/add_review_page.dart';
import 'package:flutter_with_firebase/product_review.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';
import 'product.dart';
import 'firestore_service.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage(this.product, {super.key}) : assert(product.id.isNotEmpty, 'Product ID cannot be empty');

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context);
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Image.network(product.imageUrl),
          Text(product.name), // Removed const
          Text('\$${product.price.toStringAsFixed(2)}'), // Removed const
          ElevatedButton(
            onPressed: () {
              // Add the product to the wishlist
              Provider.of<ProductProvider>(context, listen: false).addToWishlist(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} added to wishlist!')),
              );
            },
            child: Text('Add to Wishlist'),
          ),
          Expanded(
            child: StreamBuilder<List<Review>>(
              stream: firestoreService.getReviews(product.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final reviews = snapshot.data!;
                  return ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return ListTile(
                        title: Text(review.userName),
                        subtitle: Text(review.comment),
                        trailing: Text(review.rating.toString()),
                      );
                    },
                  );
                } else {
                  return const Text('No reviews yet');
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReviewPage(product: product),
                  ),
                );
              },
              child: const Text('Add Review'),
            ),
          ),
        ],
      ),
    );
  }
}