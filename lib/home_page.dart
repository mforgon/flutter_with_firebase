import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/profile_page.dart';
import 'package:provider/provider.dart';
import 'about_us_page.dart';
import 'edit_product_page.dart';
import 'home_page_appbar.dart';
import 'home_page_drawer.dart';
import 'home_page_body.dart';
import 'language/app_localizations.dart';
import 'navigation_widget/common_bottom_navigationbar.dart';
import 'theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (user == null) {
      return Scaffold(
        appBar: buildAppBar(context, themeProvider),
        body: const Center(child: Text('Please log in')),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: buildAppBar(context, themeProvider),
        drawer: buildDrawer(context, user),
        body: const HomePageBody(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProductPage()),
            );
          },
          label: Text(AppLocalizations.of(context).addProduct),
          icon: const Icon(Icons.add),
        ),
        bottomNavigationBar: CommonBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
