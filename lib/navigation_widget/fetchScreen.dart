import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  _FetchScreenState createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  final _url = 'https://api.jikan.moe/v4/anime';
  var _response = '';

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      setState(() {
        _response = response.body;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Fetch Data'),
            ),
            Text(_response),
          ],
        ),
      ),
    );
  }
}