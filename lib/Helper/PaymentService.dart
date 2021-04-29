import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_sigup_flutter/Helper/UserService.dart';
import 'package:login_sigup_flutter/Model/cart.dart';


class APIPayment{

  static Future<Cart> PaymentByCreditCard() async{
    String token = await APIService.getToken();
    int UserId = await APIService.getIdUserLogin();

    String body = jsonEncode(<String, String>{
      'UserId' : UserId.toString(),
    });
    final response = await http.Client().post('http://10.0.2.2:5000/api/Cart/PaymentByCreditCard/',

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: body,
    );
    if(response.statusCode == 200){
      return null;
    } else{
      throw Exception("Load data failed.");
    }
  }

  static Future PayOnDelivery() async{
    String token = await APIService.getToken();
    int UserId = await APIService.getIdUserLogin();

    String body = jsonEncode(<String, String>{
      'UserId' : UserId.toString(),
    });
    final response = await http.Client().post('http://10.0.2.2:5000/api/Cart/PayOnDelivery/',

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: body,
    );
    if(response.statusCode == 200){
      return null;
    } else{
      throw Exception("Load data failed.");
    }
  }
}
