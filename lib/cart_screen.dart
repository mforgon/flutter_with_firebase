import 'package:flutter/material.dart';

import 'package:flutter_with_firebase/product.dart';
import 'package:provider/provider.dart';
import 'cart_logic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_with_firebase/firestore_service.dart';
import 'language/app_localizations.dart';
import 'order_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(AppLocalizations.of(context).cartTitle),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildTotalAmountBar(),
    );
  }

  Widget _buildBody() {
    var cartItems = context.watch<CartLogic>().cartItems;
    return cartItems.isEmpty
        ? Center(
            child: Text('Your cart is empty!',
                style: Theme.of(context).textTheme.bodyLarge))
        : _buildListView(cartItems);
  }

  Widget _buildListView(Map<Product, int> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final product = items.keys.elementAt(index);
        final quantity = items[product] ?? 0;
        return _buildItem(product, quantity);
      },
    );
  }

  Widget _buildItem(Product item, int quantity) {
    return Card(
      margin: const EdgeInsets.all(4.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            ListTile(
              title: Text(item.name,
                  style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text(
                'Price: \$${item.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: 100,
              child: Image.network(item.imageUrl),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CartLogic>().decrementQuantity(item);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  quantity.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: () {
                    context.read<CartLogic>().incrementQuantity(item);
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CartLogic>().removeFromCart(item);
                  },
                  icon: Icon(Icons.delete_outline,
                      color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
            Text(
              'Subtotal: \$${(item.price * quantity).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmountBar() {
    final totalAmount = context.watch<CartLogic>().calculateTotalAmount();

    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Amount:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: totalAmount > 0
                  ? () {
                      _checkout(context);
                    }
                  : null,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

 void _checkout(BuildContext context) {
  final cartLogic = context.read<CartLogic>();
  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please log in to proceed with checkout.')),
    );
    return;
  }

  final totalAmount = cartLogic.calculateTotalAmount();

  // Show a confirmation dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Checkout'),
        content: Text('Do you want to proceed with the checkout for \$${totalAmount.toStringAsFixed(2)}?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _proceedWithCheckout(context, cartLogic, userId);
            },
          ),
        ],
      );
    },
  );
}

void _proceedWithCheckout(BuildContext context, CartLogic cartLogic, String userId) {
  final firestoreService = Provider.of<FirestoreService>(context, listen: false);
  final orderId = DateTime.now().millisecondsSinceEpoch.toString();

  // Create a list of OrderItems
  List<OrderItem> orderItems = cartLogic.cartItems.entries.map((entry) {
    return OrderItem(product: entry.key, quantity: entry.value);
  }).toList();

  final newOrder = Order(
    id: orderId,
    userId: userId,
    items: orderItems,
    totalAmount: cartLogic.calculateTotalAmount(),
    date: DateTime.now(),
  );

  firestoreService.addOrder(newOrder).then((_) {
    cartLogic.clearCart();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully!')),
    );
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error placing order: $error')),
    );
  });
}


  
}
