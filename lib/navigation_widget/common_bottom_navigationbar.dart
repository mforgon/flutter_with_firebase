import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/language/app_localizations.dart'; // Import your localization class

class CommonBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CommonBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context); // Get the localizations instance

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: localizations.home, // Use localized string
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: localizations.profile, // Use localized string
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          label: localizations.aboutUs, // Use localized string
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blueAccent,
      onTap: onItemTapped,
    );
  }
}
