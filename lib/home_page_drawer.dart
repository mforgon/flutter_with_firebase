import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'about_us_page.dart';
import 'language/app_localizations.dart';
import 'theme/theme_provider.dart';
import 'language/language_provider.dart';

Drawer buildDrawer(BuildContext context, User user) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
              MaterialPageRoute(builder: (context) => const ProfilePage()),
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
          trailing: DropdownButton<int>(
            value: themeProvider.themeIndex,
            onChanged: (int? newThemeIndex) {
              if (newThemeIndex != null) {
                themeProvider.setTheme(newThemeIndex);
              }
            },
            items: [
              DropdownMenuItem(
                value: 0,
                child: Text(AppLocalizations.of(context).systemTheme),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text(AppLocalizations.of(context).lightTheme),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text(AppLocalizations.of(context).darkTheme),
              ),
            ],
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
  );
}
