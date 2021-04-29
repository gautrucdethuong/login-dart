import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:login_sigup_flutter/Model/review.dart';
import 'package:commons/commons.dart';


class APIReview {

  // get all list
  static Future<List<Review>> fetchReviewByIdProduct(int ProductId) async {

    // String token = await APIReview.getToken();
    String body = jsonEncode(<String, String>{
      'ProductId': ProductId.toString(),
    });

    final response = await http.Client().post(
      'http://10.0.2.2:5000/api/Review/GetReviewByIdProduct',
      headers: {
        //'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',},
      body: body,
    );

    if (response.statusCode == 200) {
      return compute(Review.parseReviews, response.body);
    } else {
      throw Exception("Load data failed.");
    }
  }
}
