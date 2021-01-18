import 'package:flutter/material.dart';
import 'loginscreeen.dart';
import 'signupscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //xóa cái nhãn debug trên màn hình ứng dụng,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),

    );
  }
}




