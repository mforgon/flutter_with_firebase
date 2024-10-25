import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/language/app_localizations.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';
import 'firestore_service.dart';
import 'home_page_helpers.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final firestoreService = Provider.of<FirestoreService>(context);
    final user = FirebaseAuth.instance.currentUser;

    // Ensure the initial value of priceSort is valid
    final priceSortOptions = [
      AppLocalizations.of(context).noneSort,
      AppLocalizations.of(context).lowestToHighestSort,
      AppLocalizations.of(context).highestToLowestSort,
    ];

    if (!priceSortOptions.contains(productProvider.priceSort)) {
      productProvider.setPriceSort(priceSortOptions.first);
    }

    final categories = productProvider.getCategories(context);
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          sliver: SliverToBoxAdapter(
            child: TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).searchHint,
                prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 0.1),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
              ),
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              onChanged: (value) {
                productProvider.searchProducts(value);
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: productProvider.selectedCategory == category,
                    onSelected: (selected) {
                      productProvider.setSelectedCategory(category);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).sortByPrice,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                DropdownButton<String>(
                  value: productProvider.priceSort,
                  items: priceSortOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Theme.of(context).textTheme.bodyLarge?.color,),
                        
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      productProvider.setPriceSort(newValue);
                    }
                  },
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                  underline: Container(
                    height: 1,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  icon: const Icon(Icons.arrow_drop_down, size: 20),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: buildHorizontalProductList(
            context,
            AppLocalizations.of(context).recommendedForYou,
            productProvider.getRecommendedProducts(),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context).allProducts,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  itemCount: productProvider.filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final product = productProvider.filteredProducts[index];
                    return buildProductCard(context, product, user, firestoreService, productProvider);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
