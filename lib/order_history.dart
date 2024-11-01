import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'language/app_localizations.dart';
import 'order_model.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
            Text(
                'Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(order.date)}'),
            const SizedBox(height: 8.0),
            const Text('Products:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...order.items.map((orderItem) {
              return ProductTile(orderItem: orderItem);
            }),
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final OrderItem orderItem;

  const ProductTile({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Image.network(
          orderItem.product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(orderItem.product.name),
        subtitle: Text(
            '\$${orderItem.product.price.toStringAsFixed(2)} x ${orderItem.quantity}'),
      ),
    );
  }
}

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(
          child: Text(AppLocalizations.of(context).loginToViewOrders));
    }

    return Scaffold(
      appBar: AppBar(
         title: Text(AppLocalizations.of(context).orderHistoryTitle),
      ),
      body: StreamBuilder<List<Order>>(
        stream: firestoreService.getOrders(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${AppLocalizations.of(context).error}: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context).noOrdersFound));
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
