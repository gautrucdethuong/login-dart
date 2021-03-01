
import 'dart:convert';

class User{
  //declare variable
  int id;
  String fullName;
  String email;
  String username;
  String phoneNumber;
  String password;
  String role;
  String token;

  //constructor
  User({this.id, this.fullName, this.email,  this.username, this.phoneNumber, this.password});


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

  // api get data list
  static List<User> parseUsers(String responseBody) {
    var repoData = jsonDecode(responseBody);
    final parsed = repoData['data'].cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

}