import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:login_sigup_flutter/GUI/loginscreeen.dart';
import 'package:login_sigup_flutter/Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService{

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
  // remove token
  static removeToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.commit();
  }




  // get all list
  static Future<List<User>> fetchUser() async{
    String token = await APIService.getToken();

    final response = await http.Client().get('http://10.0.2.2:5000/api/user',
      headers: {'Authorization': 'Bearer $token','Content-Type': 'application/json','Accept': 'application/json',},
    );
    return compute(User.parseUsers, response.body);
  }

  // get user details
  static Future<List<User>> getUserDetails(String id) async{
    String token = await APIService.getToken();

    final response = await http.Client().get('http://10.0.2.2:5000/api/user/$id',
      headers: {'Authorization': 'Bearer $token','Content-Type': 'application/json','Accept': 'application/json',},
    );
    return compute(User.parseUsers, response.body);
  }


  //create user
  static Future<User> createUser(String username, String password, String fullName, String email, String phoneNumber) async{
    String body = jsonEncode(<String, String>{
      'username': username,
      'password': password,
      'fullname': fullName,
      'email': email,
      'phone': phoneNumber,
    });
    final response = await http.Client().post('http://10.0.2.2:5000/api/user',

      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }


  // update profile
  static Future<User> updateProfileUser(String id, String username, String password, String fullName, String email, String phoneNumber) async{

    String token = await APIService.getToken();
    String body = jsonEncode(<String, String>{
      'username' : username,
      'password': password,
      'fullname': fullName,
      'email': email,
      'phone': phoneNumber,
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
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }


  // delete user
  static Future<User> deleteUser(String id) async {

    String token = await APIService.getToken();
    final response = await http.Client().delete(
      'http://10.0.2.2:5000/api/user/$id',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if(response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load Data');
    }
  }
}
