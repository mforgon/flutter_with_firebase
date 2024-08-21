import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/order_model.dart';
import 'package:flutter_with_firebase/product.dart';
import 'package:flutter_with_firebase/profile_page.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';
import 'product_details_page.dart';
import 'edit_product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'package:flutter_with_firebase/firestore_service.dart';
import 'order_history.dart'; // Ensure the correct import path

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final firestoreService = Provider.of<FirestoreService>(context);
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('E-commerce Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _signOut(context),
            ),
          ],
        ),
        body: const Center(child: Text('Please log in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProductPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          )

          ,
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Ensure firestoreService is available
              if (firestoreService == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('FirestoreService not available')),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderHistoryPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                productProvider.searchProducts(value);
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: productProvider.filteredProducts.length,
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () {
                  final product = productProvider.filteredProducts[i];
                  if (product.id.isEmpty) {
                    print('Product ID is empty');
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(product),
                    ),
                  );
                },
                child: GridTile(
                  child: Image.network(
                      productProvider.filteredProducts[i].imageUrl,
                      fit: BoxFit.cover),
                  footer: GridTileBar(
                    backgroundColor: Colors.black87,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productProvider.filteredProducts[i].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '\$${productProvider.filteredProducts[i].price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProductPage(
                                    product:
                                        productProvider.filteredProducts[i]),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            productProvider.deleteProduct(
                                productProvider.filteredProducts[i].id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            _placeOrder(
                                context,
                                productProvider.filteredProducts[i],
                                user.uid,
                                firestoreService);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder(BuildContext context, Product product, String userId,
      FirestoreService firestoreService) {
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();
    final newOrder = Order(
      id: orderId,
      userId: userId,
      products: [product],
      totalAmount: product.price,
      date: DateTime.now(),
    );

    firestoreService.addOrder(newOrder).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error placing order: $error')),
      );
    });
  }
}
