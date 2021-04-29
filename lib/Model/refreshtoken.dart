
import 'package:flutter/cupertino.dart';

class RefreshToken{

  final String token;
  final String refreshToken;

  @override
  RefreshToken({@required this.token,@required this.refreshToken});

  @override
  int get hashCode => hashValues(token, refreshToken);


  factory RefreshToken.fromMap(Map<String, dynamic> json) {
    return RefreshToken(
      token: json['Token'] as String,
      refreshToken: json['RefreshToken'] as String,
    );
  }
}