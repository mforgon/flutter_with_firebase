import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'connection_provider.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off,
              size: 100,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 20),
            Text(
              'No Internet Connection',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Please check your connection and try again',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      // Simulate a delay for the loading indicator
                      await Future.delayed(const Duration(seconds: 2));

                      // Check connectivity
                      Provider.of<ConnectivityProvider>(context, listen: false)
                          .checkConnectivity();

                      // Check if the internet is back
                      if (Provider.of<ConnectivityProvider>(context, listen: false).isOnline) {
                        // Navigate to the normal application screen
                        Navigator.of(context).pop(); // or use Navigator.pushReplacement to go to the main screen
                      } else {
                        // Stay on the same screen and show the retry button again
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    child: const Text('Retry'),
                  ),
          ],
        ),
      ),
    );
  }
}
