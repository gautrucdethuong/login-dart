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
  final String avatar;
  final String refreshToken;

  //constructor
  User({@required this.id,@required this.fullName,@required this.email,@required this.username,@required this.phoneNumber,@required this.password, this.token, this.avatar, @required this.refreshToken});

  //get data
  @override
  int get hashCode => hashValues(id, fullName, email, username, phoneNumber, password, token, avatar, refreshToken);


  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['user_id'] as int,
      fullName: json['user_fullname'] as String,
      email: json['user_email'] as String,
      username: json['user_username'] as String,
      phoneNumber: json['user_phone'] as String,
      password: json['user_password'] as String,
      avatar: json['user_avt'] as String,
      refreshToken: json['user_refreshToken'] as String,
    );
  }

  // parse list User data
  static List<User> parseUsers(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'].cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromMap(json)).toList();
  }

  // parse User data by id
  static User parseUser(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'];
    return User.fromMap(parsed);
  }

}