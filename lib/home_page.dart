import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/language/app_localizations.dart';
import 'package:flutter_with_firebase/language/language_provider.dart';
import 'package:flutter_with_firebase/order_model.dart';
import 'package:flutter_with_firebase/product.dart';
import 'package:flutter_with_firebase/profile_page.dart';
import 'package:flutter_with_firebase/theme/theme_provider.dart';
import 'package:flutter_with_firebase/wishlist.dart';
import 'package:provider/provider.dart';
import 'about_us_page.dart';
import 'navigation_widget/common_bottom_navigationbar.dart';
import 'product_provider.dart';
import 'product_details_page.dart';
import 'edit_product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'package:flutter_with_firebase/firestore_service.dart';
import 'order_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All';
  List<String> _categories = [];
  String _priceSort = "";
  int _selectedIndex = 0;

  // List of pages to navigate to
  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
    const AboutUsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _categories = [
      AppLocalizations.of(context).allCategory,
      AppLocalizations.of(context).electronicsCategory,
      AppLocalizations.of(context).jeweleryCategory,
      AppLocalizations.of(context).mensClothingCategory,
      AppLocalizations.of(context).womensClothingCategory,
    ];
    _priceSort = AppLocalizations.of(context).noneSort;
  }

  void _navigateToAboutUsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final firestoreService = Provider.of<FirestoreService>(context);
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).appTitle),
          backgroundColor: themeProvider.themeMode == ThemeMode.dark
              ? Colors.black
              : Colors.white,
        ),
        body: const Center(child: Text('Please log in')),
      );
    }

    return GestureDetector(
      onTap: () {
        // This will unfocus the search bar when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).appTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: themeProvider.themeMode == ThemeMode.dark
              ? Colors.black
              : Colors.white,
          foregroundColor: themeProvider.themeMode == ThemeMode.dark
              ? Colors.white
              : Colors.black,
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
                  MaterialPageRoute(builder: (context) => const WishlistPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.receipt_long, color: themeProvider.themeMode == ThemeMode.dark
              ? Colors.white
              : Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderHistoryPage()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                accountName: Text(user.displayName ?? 'User'),
                accountEmail: Text(user.email ?? ''),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.blueAccent),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(AppLocalizations.of(context).profile),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(AppLocalizations.of(context).signOut),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUsPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: Text(AppLocalizations.of(context).theme),
                trailing: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return DropdownButton<ThemeMode>(
                      value: themeProvider.themeMode,
                      onChanged: (ThemeMode? newThemeMode) {
                        if (newThemeMode != null) {
                          themeProvider.setThemeMode(newThemeMode);
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text(AppLocalizations.of(context).systemTheme),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text(AppLocalizations.of(context).lightTheme),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text(AppLocalizations.of(context).darkTheme),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context).language),
                trailing: Consumer<LanguageProvider>(
                  builder: (context, languageProvider, child) {
                    return DropdownButton<String>(
                      value: languageProvider.locale.languageCode,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          languageProvider.setLocale(Locale(newValue));
                        }
                      },
                      items: const [
                        DropdownMenuItem(value: 'km', child: Text('ខ្មែរ')),
                        DropdownMenuItem(value: 'en', child: Text('English')),
                        DropdownMenuItem(value: 'zh', child: Text('中文')),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).searchHint,
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).iconTheme.color),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                          color: Theme.of(context).dividerColor, width: 0.1),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color),
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
                  children: _categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                          productProvider.filterProductsByCategory(category);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).sortByPrice,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    DropdownButton<String>(
                      value: _priceSort,
                      items: <String>[
                        AppLocalizations.of(context).noneSort,
                        AppLocalizations.of(context).lowestToHighestSort,
                        AppLocalizations.of(context).highestToLowestSort,
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _priceSort =
                                newValue; // Update the _priceSort variable
                          });
                          if (newValue ==
                              AppLocalizations.of(context)
                                  .lowestToHighestSort) {
                            productProvider.sortProductsByPrice(true);
                          } else if (newValue ==
                              AppLocalizations.of(context)
                                  .highestToLowestSort) {
                            productProvider.sortProductsByPrice(false);
                          }
                        }
                      },
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black87),
                      underline: Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _buildHorizontalProductList(
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
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8.0),
                      itemCount: productProvider.filteredProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = productProvider.filteredProducts[index];
                        return _buildProductCard(context, product, user,
                            firestoreService, productProvider);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProductPage()),
            );
          },
          label: Text((AppLocalizations.of(context).addProduct)),
          icon: const Icon(Icons.add),
        ),
        bottomNavigationBar: CommonBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildHorizontalProductList(
      BuildContext context, String title, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(product),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8.0)),
                          child: Image.network(
                            product.imageUrl,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product, User? user,
      FirestoreService firestoreService, ProductProvider productProvider) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16.0)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 12.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProductPage(product: product),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20),
                          onPressed: () {
                            productProvider.deleteProduct(product.id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart, size: 20),
                          onPressed: () {
                            _placeOrder(
                                context, product, user!.uid, firestoreService);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
        const SnackBar(content: Text('Error placing order')),
      );
    });
  }
}
