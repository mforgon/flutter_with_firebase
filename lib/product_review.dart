import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String userId;
  final String userName;
  final String comment;
  final double rating;

  Review({
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
  });

  factory Review.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Review(
      userId: data['userId'],
      userName: data['userName'],
      comment: data['comment'],
      rating: data['rating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'comment': comment,
      'rating': rating,
    };
  }
}
