import 'dart:convert';
import 'package:flutter/cupertino.dart';


class User{
  //declare variable
  final int id;
  final String fullName;
  final String email;
  final String username;
  final String phoneNumber;
  final String password;
  String role;
  final String token;

  //constructor
  User({@required this.id,@required this.fullName,@required this.email,@required this.username,@required this.phoneNumber,@required this.password, this.token});

  //get data
  @override
  int get hashCode => hashValues(id, fullName, email, username, phoneNumber, password, token);


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'] as int,
      fullName: json['fullname'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      phoneNumber: json['phone'] as String,
      password: json['password'] as String,
    );
  }

  // parse User data
  static List<User> parseUsers(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'].cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

}