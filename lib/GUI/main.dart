import 'dart:io';
import 'package:flutter/material.dart';
import 'CartPage/page/cart_null_page.dart';
import 'CartPage/page/credit_cart_page.dart';
import 'CartPage/page/method_checkout_page.dart';
import 'CartPage/page/wallet_page_checkout.dart';
import 'HomePage/Product/constants.dart';
import 'HomePage/Product/Welcomepage.dart';


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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomePage(),
    );
  }
}




