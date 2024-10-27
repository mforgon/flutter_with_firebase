import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/language/app_localizations.dart';

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
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: AppLocalizations.of(context).profile,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          label: AppLocalizations.of(context).aboutUs,
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blueAccent, // Highlight the selected icon in blue
      unselectedItemColor: Colors.grey, // Optional: Set color for unselected icons
      onTap: onItemTapped,
    );
  }
}
