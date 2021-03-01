import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'loginscreeen.dart';


Future<void> main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //xóa nhãn debug trên màn hình ứng dụng,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}




