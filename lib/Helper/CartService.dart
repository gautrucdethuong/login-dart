import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:login_sigup_flutter/Helper/UserService.dart';
import 'package:login_sigup_flutter/Model/cart.dart';


class APICart{
  // get all list
  static Future<List<Cart>> fetchCartByIdUser() async{
    String token = await APIService.getToken();
    int id = await APIService.getIdUserLogin();

    String body = jsonEncode(<String, String>{
      'UserId' : id.toString(),
    });
    final response = await http.Client().post('http://10.0.2.2:5000/api/Cart/GetListByIdUser/',

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: body,
    );

    if(response.statusCode == 200){
      return await compute(Cart.parseCarts, response.body);
    } else{
      throw Exception("Load data failed.");
    }

  }

  static Future<Cart> addProductInCart(int productId) async{
    String token = await APIService.getToken();
     int UserId = await APIService.getIdUserLogin();

    String body = jsonEncode(<String, String>{
      'UserId' : UserId.toString(),
      'ProductId': productId.toString(),
      'Quantity': 1.toString(),
    });
    final response = await http.Client().post('http://10.0.2.2:5000/api/Cart/',

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: body,
    );
    if(response.statusCode == 200){

    } else{
      throw Exception("Load data failed.");
    }
  }

  static Future<int> countProductByCart() async{
    String token = await APIService.getToken();
    int UserId = await APIService.getIdUserLogin();

    String body = jsonEncode(<String, String>{
      'UserId' : UserId.toString(),
    });
    final response = await http.Client().post('http://10.0.2.2:5000/api/Cart/CountProduct/',

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: body,
    );
    if(response.statusCode == 200){
      return await compute(Cart.CountProduct, response.body);
    } else{
      throw Exception("Load data failed.");
    }
  }

  static Future<double> TotalValueProduct() async{
    String token = await APIService.getToken();
    int UserId = await APIService.getIdUserLogin();

    String body = jsonEncode(<String, String>{
      'UserId' : UserId.toString(),
    });
    final response = await http.Client().post('http://10.0.2.2:5000/api/Cart/TotalPayment/',

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: body,
    );
    if(response.statusCode == 200){
      return await compute(Cart.TotalValueProduct, response.body);
    } else{
      throw Exception("Load data failed.");
    }
  }

}
