import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:login_sigup_flutter/Model/user.dart';



class Review extends User{

  //declare variable
  final int review_id;
  final String review_content;
  final String review_UserId;
  final int review_ProductId;
  final int review_Rating;



  //constructor
  Review({@required this.review_id,@required this.review_content,@required this.review_UserId, this.review_ProductId, @required this.review_Rating});

  //get data
  @override
  int get hashCode => hashValues(review_id, review_content, review_UserId, review_ProductId, review_Rating);


  factory Review.fromMap(Map<String, dynamic> json) {
    return Review(
      review_id: json['reviewId'] as int,
      review_content: json['content'] as String,
      review_UserId: json['userId'] as String,
      review_ProductId: json['productId'] as int,
      review_Rating: json['rating'] as int,
    );
  }


  // parse list User data
  static List<Review> parseReviews(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'].cast<Map<String, dynamic>>();
    return parsed.map<Review>((json) => Review.fromMap(json)).toList();
  }

  // parse User data by id
  static Review parseReview(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'];
    return Review.fromMap(parsed);
  }

}