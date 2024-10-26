import 'package:flutter/material.dart';

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
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About Us',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blueAccent, // Highlight the selected icon in blue
      unselectedItemColor: Colors.grey, // Optional: Set color for unselected icons
      onTap: onItemTapped,
    );
  }
}
