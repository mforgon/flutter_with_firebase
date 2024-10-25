import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/order_history.dart';
import 'package:flutter_with_firebase/product.dart';
import 'package:provider/provider.dart';
import 'cart_logic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_with_firebase/firestore_service.dart';
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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Cart Screen"),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildTotalAmountBar(),
    );
  }

  Widget _buildBody() {
    var cartList = context.watch<CartLogic>().cartList;
    return cartList.isEmpty
        ? Center(child: Text('Your cart is empty!'))
        : _buildListView(cartList.cast<Product>());
  }

  Widget _buildListView(List<Product> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildItem(items[index]);
      },
    );
  }

  Widget _buildItem(Product item) {
    return ListTile(
      title: Text(item.name),
      subtitle: SizedBox(
        height: 100,
        child: Image.network(item.imageUrl),
      ),
      trailing: IconButton(
        onPressed: () {
          context.read<CartLogic>().toggleProductInCart(item);
        },
        icon: Icon(Icons.cancel),
      ),
    );
  }

  Widget _buildTotalAmountBar() {
    final totalAmount = context.watch<CartLogic>().calculateTotalAmount();

    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: totalAmount > 0
                  ? () {
                      _checkout(context);
                    }
                  : null,
              child: Text('Checkout'),
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
        SnackBar(content: Text('Please log in to proceed with checkout.')),
      );
      return;
    }

    final firestoreService =
        Provider.of<FirestoreService>(context, listen: false);

    final orderId = DateTime.now().millisecondsSinceEpoch.toString();
    final newOrder = Order(
      id: orderId,
      userId: userId,
      products: cartLogic.cartList,
      totalAmount: cartLogic.calculateTotalAmount(),
      date: DateTime.now(),
    );

    firestoreService.addOrder(newOrder).then((_) {
      cartLogic.clearCart();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error placing order: $error')),
      );
    });
  }
}
