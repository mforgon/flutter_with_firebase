import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/add_review_page.dart';
import 'package:flutter_with_firebase/product_review.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';
import 'product.dart';
import 'firestore_service.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage(this.product, {super.key})
      : assert(product.id.isNotEmpty, 'Product ID cannot be empty');

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context);
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-${product.id}',
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.green,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Category: ${product.category}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .addToWishlist(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} added to wishlist!')),
                      );
                    },
                    icon: const Icon(Icons.favorite),
                    label: const Text('Add to Wishlist', ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white, 
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Reviews',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<List<Review>>(
              stream: firestoreService.getReviews(product.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final reviews = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(review.userName[0]),
                        ),
                        title: Text(review.userName),
                        subtitle: Text(review.comment),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            Text(review.rating.toString()),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No reviews yet'));
                }
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddReviewPage(product: product),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Add Review'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
