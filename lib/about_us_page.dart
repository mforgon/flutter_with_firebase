import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/home_page.dart';
import 'package:flutter_with_firebase/profile_page.dart';
import 'navigation_widget/common_bottom_navigationbar.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int _selectedIndex = 2; // Set the initial index to 2 for "About Us"

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://media.istockphoto.com/id/1360092910/photo/words-with-about-us-web-concept-idea.jpg?s=612x612&w=0&k=20&c=TyTppcG3XxtU8Oc8C9O455Lnc0auZHlPEOJBuMDzFBE='),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Our Mission',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, enim eget tristique mattis, sem elit lacinia nibh, nec malesuada nisi metus vel nunc. Sed id nisi eget nisl lacinia ultricies.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Our Team',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: [
                _buildTeamMember(
                  'John Doe',
                  'CEO',
                  'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                ),
                _buildTeamMember(
                  'Jane Smith',
                  'Product Manager',
                  'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                ),
                _buildTeamMember(
                  'Jane Doam',
                  'CEO',
                  'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                ),
                _buildTeamMember(
                  'Jane Smith',
                  'Product Manager',
                  'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
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

  Widget _buildTeamMember(String name, String position, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Text(position),
            ],
          ),
        ],
      ),
    );
  }
}
