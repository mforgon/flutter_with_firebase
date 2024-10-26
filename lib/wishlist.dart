import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/cart_logic.dart';
import 'package:flutter_with_firebase/product_provider.dart';
import 'package:provider/provider.dart';

import 'language/app_localizations.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final wishlist = productProvider?.wishlist ?? [];
    final cartLogic =
        Provider.of<CartLogic>(context); // Accessing the cart logic

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).wishlistTitle),
      ),
      body: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final product = wishlist[index];
          return ListTile(
            leading: Image.network(
              product.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    // Only add to cart, do not toggle both
                    cartLogic.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart!')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    productProvider.removeFromWishlist(product.id);
                    cartLogic.removeFromWishlist(product);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
