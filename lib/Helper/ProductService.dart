import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:login_sigup_flutter/Model/product.dart';
import 'package:login_sigup_flutter/Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:commons/commons.dart';



class APIProduct{

  //set token value
  static Future<bool> setToken(String value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", value);
  }
  // get token
  static Future<String> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  //set id user login
  static Future<bool> setIdUserLogin(int id) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt("idUser", id);
  }
  // get id user login
  static Future<int> getIdUserLogin() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("idUser");
  }

  // remove token
  static removeToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.commit();
  }


  // get all list
  static Future<List<Product>> fetchProduct() async{
    String token = await APIProduct.getToken();

    final response = await http.Client().get('http://10.0.2.2:5000/api/product',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',},
    );

    if(response.statusCode == 200){
      return compute(Product.parseProducts, response.body);

    }else if(response.statusCode == 401){
      
    } else{
      throw Exception("Load data failed.");
    }

  }

  // get all list
  static Future<List<Product>> fetchSeller() async{

    String token = await APIProduct.getToken();

    final response = await http.Client().get('http://10.0.2.2:5000/api/product/seller',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',},
    );

    if(response.statusCode == 200){
      return compute(Product.parseProducts, response.body);
    }else{
      throw Exception("Load data failed.");
    }

  }

  // get product details
  static Future<Product> getProductDetail(int id) async{
    String token = await APIProduct.getToken();
    final response = await http.Client().get('http://10.0.2.2:5000/api/product/$id',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',},
    );

    if(response.statusCode == 200){
      return compute(Product.parseProduct, response.body);
    }else{
      throw Exception("Load data failed.");
    }

  }

  // update profile
  static Future<User> updateProduct(String id, String username, String password, String fullName, String email, String phoneNumber) async{

    String token = await APIProduct.getToken();
    String body = jsonEncode(<String, String>{
      'user_username' : username,
      'user_password': password,
      'user_fullname': fullName,
      'user_email': email,
      'user_phone': phoneNumber,
    });
    final response = await http.Client().put('http://10.0.2.2:5000/api/user/$id',

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return User.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  // delete user
  static Future<User> deleteProduct(String id) async {

    String token = await APIProduct.getToken();
    final response = await http.Client().delete(
      'http://10.0.2.2:5000/api/user/$id',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if(response.statusCode == 200){
      return User.fromMap(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load Data');
    }
  }

}
