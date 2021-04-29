import 'dart:convert';
import 'package:flutter/cupertino.dart';


class Product{
  //declare variable
  final int id;
  final String productName;
  final String productOrigin;
  final double productPrice;
  final String productDescription;
  final String productSize;
  final String productRating;
  final String productImage;


  //constructor
  Product({@required this.id,@required this.productName,@required this.productOrigin,@required this.productPrice,@required this.productDescription,@required this.productSize, this.productRating, this.productImage});

  //get data
  @override
  int get hashCode => hashValues(id, productName, productOrigin, productPrice, productDescription, productSize, productRating, productImage);


  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'] as int,
      productName: json['product_name'] as String,
      productOrigin: json['product_origin'] as String,
      productPrice: json['product_price'] as double,
      productDescription: json['product_description'] as String,
      productSize: json['product_size'] as String,
      productRating: json['product_rating'] as String,
      productImage: json['product_image'] as String,
    );
  }


  // parse list User data
  static List<Product> parseProducts(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'].cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromMap(json)).toList();
  }

  // parse User data by id
  static Product parseProduct(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'];
    return Product.fromMap(parsed);
  }



}