import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/product_provider.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: productProvider.wishlist.length,
        itemBuilder: (context, index) {
          final product = productProvider.wishlist[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                productProvider.removeFromWishlist(product.id);
              },
            ),
          );
        },
      ),
    );
  }
}
