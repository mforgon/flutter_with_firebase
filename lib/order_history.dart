import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'order_model.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
            Text('Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(order.date)}'),
            SizedBox(height: 8.0),
            Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...order.products.map((product) {
              return ProductTile(product: product);
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      ),
    );
  }
}
class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('Please log in to view your order history.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: StreamBuilder<List<Order>>(
        stream: firestoreService.getOrders(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found.'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(order: order);
              },
            );
          }
        },
      ),
    );
  }
}
