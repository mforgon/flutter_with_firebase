import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/cart_logic.dart';
import 'package:flutter_with_firebase/firestore_service.dart';
import 'package:flutter_with_firebase/order_history.dart';
import 'package:flutter_with_firebase/order_model.dart';
import 'package:flutter_with_firebase/product_provider.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartLogic =
        Provider.of<CartLogic>(context); // Accessing the cart logic

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: productProvider.wishlist.length,
        itemBuilder: (context, index) {
          final product = productProvider.wishlist[index];
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
                    // Add product to cart
                    cartLogic.toggleProductInCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart!')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    productProvider.removeFromWishlist(product.id);
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
