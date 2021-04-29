import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:login_sigup_flutter/Model/product.dart';
import 'package:login_sigup_flutter/Model/user.dart';

class Cart {
  final int cartId;
  final int quantity;
  final String userId;
  final int productId;
  final String requestDate;
  final Product product;
  final User user;

  Cart({@required this.cartId,@required this.quantity,@required this.userId,@required this.productId,@required this.requestDate, @required this.product, @required this.user});

  @override
  int get hashCode => hashValues(cartId, quantity, userId, productId, requestDate, product, user);

  factory Cart.fromMap(Map<String, dynamic> json) {
    return Cart(
      cartId: json['cartId'] as int,
      quantity: json['quantity'] as int,
      userId: json['userId'] as String,
      productId: json['productId'] as int,
      requestDate: json['request_Date'] as String,

    );
  }


  // parse list User data
  static List<Cart> parseCarts(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'].cast<Map<String, dynamic>>();
    return parsed.map<Cart>((json) => Cart.fromMap(json)).toList();

  }

  // parse User data by id
  static int CountProduct(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'];
    return parsed;
  }


  // parse User data by id
  static double TotalValueProduct(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'];
    return parsed;
  }

}
