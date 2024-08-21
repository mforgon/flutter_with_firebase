import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/product.dart';

class AddReviewPage extends StatefulWidget {
  final Product product;

  const AddReviewPage({required this.product, super.key});

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _commentController = TextEditingController();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Review for ${widget.product.name}'),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Comment',
              ),
            ),
            Slider(
              value: _rating,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
              min: 0,
              max: 5,
              divisions: 5,
              label: 'Rating: $_rating',
            ),
            ElevatedButton(
              onPressed: () {
                // Add review submission logic here
                // For example, call a method from FirestoreService to save the review
                Navigator.pop(context); // Go back after saving the review
              },
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
