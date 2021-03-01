import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:login_sigup_flutter/Model/user.dart';

class APIService{
  // get all list
  static Future<List<User>> fetchUser() async{
    final response = await http.Client().get('http://10.0.2.2:5000/api/user/');
    return compute(User.parseUsers, response.body);
  }

  //login
  static Future Login(String email, String password) async{
    /*final response = await http.Client().post('http://10.0.2.2:5000/api/Token/login', headers: {"Accept":"Application/json"},
    body: {'email': email, 'password'= password});
    return jsonDecode(response.body);
  }*/


}
