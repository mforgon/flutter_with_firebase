import 'package:flutter/material.dart';
import 'navigation_widget/common_bottom_navigationbar.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int _selectedIndex = 2; // Set the initial index to 2 for "About Us"

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add navigation logic here if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, enim eget tristique mattis, sem elit lacinia nibh, nec malesuada nisi metus vel nunc. Sed id nisi eget nisl lacinia ultricies.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Team',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/team_member1.jpg'),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John Doe'),
                    Text('CEO'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/team_member2.jpg'),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jane Smith'),
                    Text('Product Manager'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}