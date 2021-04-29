import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:login_sigup_flutter/Model/refreshtoken.dart';
import 'package:login_sigup_flutter/Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:commons/commons.dart';

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

  // get all list
  static Future<List<User>> fetchUser() async{
    String token = await APIService.getToken();

    final response = await http.Client().get('http://10.0.2.2:5000/api/user',
      headers: {
      'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',},
    );

    if(response.statusCode == 200){
      return compute(User.parseUsers, response.body);
    }else{
      throw Exception("Load data failed.");
    }

  }

  // get user details
  static Future<User> getUserDetail() async{

    String token = await APIService.getToken();
    int id = await APIService.getIdUserLogin();

    final response = await http.Client().get('http://10.0.2.2:5000/api/user/$id',
      headers: {'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',},
    );

    if(response.statusCode == 200){
      return compute(User.parseUser, response.body);
    }else{
      throw Exception("Load data failed.");
    }

  }

  // update profile
  static Future<User> updateProfileUser(String id, String username, String password, String fullName, String email, String phoneNumber) async{

    String token = await APIService.getToken();
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
      return User.fromMap(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load Data');
    }
  }

  static Future<RefreshToken> logout(String refrechToken, String token) async{
    String token = await APIService.getToken();
    String body = jsonEncode(<String, String>{
      'RefreshToken' : refrechToken,
      'Token': token,
    });
    final response = await http.Client().post(
      "http://10.0.2.2:5000/api/AuthenManager/revoke",
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      body: body,
    );
    if(response.statusCode == 200){
      return RefreshToken.fromMap(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load Data');
    }
  }


  // get user details
  static Future<User> getUserDetailReview(String id) async{

    String token = await APIService.getToken();

    final response = await http.Client().get('http://10.0.2.2:5000/api/user/$id',
      headers: {'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',},
    );

    if(response.statusCode == 200){
      return compute(User.parseUser, response.body);
    }else{
      throw Exception("Load data failed.");
      }
    }
  }
