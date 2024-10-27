import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/cart_logic.dart';
import 'package:flutter_with_firebase/cart_screen.dart';
import 'package:provider/provider.dart';
import 'language/app_localizations.dart';
import 'product_provider.dart';
import 'theme/theme_provider.dart';
import 'wishlist.dart';
import 'order_history.dart';

AppBar buildAppBar(BuildContext context, ThemeProvider themeProvider) {
  final productProvider = Provider.of<ProductProvider>(context);

  return AppBar(
    title: Text(
      AppLocalizations.of(context).appTitle,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    ),
    centerTitle: false,
    elevation: 0.0,
    backgroundColor: Theme.of(context).colorScheme.surface,
    foregroundColor: Theme.of(context).colorScheme.onSurface,
    actions: [
      IconButton(
        icon: Stack(
          children: [
            const Icon(Icons.favorite, color: Colors.redAccent),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  '${productProvider.wishlist.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const WishlistPage()),
          );
        },
      ),
      IconButton(
        icon: Icon(Icons.receipt_long,
            color: Theme.of(context).colorScheme.onSurface),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
          );
        },
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CartScreen(),
          ));
        },
        icon: Badge(
          label: Text("${context.watch<CartLogic>().numOfItems}"),
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    ],
  );
}
