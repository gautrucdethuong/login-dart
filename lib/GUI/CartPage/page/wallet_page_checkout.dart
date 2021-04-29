import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:commons/commons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/home/home_screen.dart';
import 'package:login_sigup_flutter/Helper/CartService.dart';
import 'package:login_sigup_flutter/Helper/PaymentService.dart';
import 'package:login_sigup_flutter/Helper/UserService.dart';
import 'package:login_sigup_flutter/Model/cart.dart';
import 'package:login_sigup_flutter/Model/user.dart';
import 'cart_page_shopping.dart';
import 'method_checkout_page.dart';
import 'dart:math';

class ConfirmOrderPage extends StatefulWidget {

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {

  final String address = "405/15 Truong Chinh, P14, Tan Binh, Ho Chi Minh";
  final String phone="0832511369";
  final String codePayment = "1549658455545";
  final double delivery = 22.22;
  bool visible = false ;
  int randomNumber = Random().nextInt(10000);

  Widget buildAppBar(BuildContext context){
    return AppBar(
      title: const Text("Order detail"),
      centerTitle: true,
      backgroundColor: Colors.deepOrange,
      leading: IconButton(icon: Icon(Icons.keyboard_backspace),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CheckoutOnePage()));
        },
      ),
    );
  }

  Widget buildBtnPayment(BuildContext context){
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.deepOrange,
        onPressed: () async {
          await APIPayment.PayOnDelivery();
          successDialog(context, "Payment ID. $randomNumber ",
            title: "Payment Successful!",
            neutralAction: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          );
        },
        child: Text("Confirm Order", style: TextStyle(
            color: Colors.white
        ),),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return FutureBuilder(
        future: APIService.getUserDetail(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot){
          if (snapshot.hasData){
            User user = snapshot.data;
            return FutureBuilder(
                future: APICart.TotalValueProduct(),
                builder: (BuildContext context, AsyncSnapshot<double> snapshot){
                  if(snapshot.hasData){
                    double count = snapshot.data;
                    final double total = count.toDouble();
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Name Order"),
                              Text(user.fullName, style: TextStyle(color: Colors.red),),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Subtotal"),
                              Text(count.toString()),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Delivery fee"),
                              Text("+ $delivery"),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Total", style: Theme.of(context).textTheme.title,),
                              Text("\$ ${total + delivery}", style: Theme.of(context).textTheme.title),
                            ],
                          ),
                          SizedBox(height: 20.0,),
                          Container(
                              color: Colors.grey.shade200,
                              padding: EdgeInsets.all(8.0),
                              width: double.infinity,
                              child: Text("Delivery Address".toUpperCase())
                          ),
                          Column(
                            children: <Widget>[
                              RadioListTile(
                                selected: true,
                                value: address,
                                groupValue: address,
                                title: Text(address),
                                onChanged: (value){},
                              ),
                              RadioListTile(
                                selected: false,
                                value: "New Address",
                                groupValue: address,
                                title: Text("Choose new delivery address"),
                                onChanged: (value){

                                },
                              ),
                              Container(
                                  color: Colors.grey.shade200,
                                  padding: EdgeInsets.all(8.0),
                                  width: double.infinity,
                                  child: Text("Contact Number".toUpperCase())
                              ),
                              RadioListTile(
                                selected: true,
                                value: user.phoneNumber,
                                groupValue: user.phoneNumber,
                                title: Text(user.phoneNumber),
                                onChanged: (value){},
                              ),
                              RadioListTile(
                                selected: false,
                                value: "New Phone",
                                groupValue: phone,
                                title: Text("Choose new contact number"),
                                onChanged: (value){},
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0,),
                          Container(
                              color: Colors.grey.shade200,
                              padding: EdgeInsets.all(8.0),
                              width: double.infinity,
                              child: Text("Payment Option".toUpperCase())
                          ),
                          RadioListTile(
                            groupValue: true,
                            value: true,
                            title: Text("Cash on Delivery"),
                            onChanged: (value){},
                          ),
                          buildBtnPayment(context),
                        ],
                      ),
                    );
                  }else{
                    return buildMenuCart();
                  }
                }
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  Widget buildMenuCart(){
    return Center(
        child: FlatButton (
          child: Text("Shopping Now"),
          onPressed: () {
          },
          color: Colors.red,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.red)
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }
}
