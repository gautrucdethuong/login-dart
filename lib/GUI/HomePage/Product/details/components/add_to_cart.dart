import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/constants.dart';
import 'package:login_sigup_flutter/Helper/CartService.dart';
import 'package:login_sigup_flutter/Model/product.dart';

class AddToCart extends StatelessWidget {

  final Product product;

  const AddToCart({
    Key key,
    @required this.product,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Colors.blue,
                    onPressed: () async {
                      String shareResponse = "Add successful.";
                      await APICart.addProductInCart(product.id);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(shareResponse, style: TextStyle(color: Colors.black),), backgroundColor: Colors.green,));
                    },
                    child: Text(
                      "ADD TO CART".toUpperCase(),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
