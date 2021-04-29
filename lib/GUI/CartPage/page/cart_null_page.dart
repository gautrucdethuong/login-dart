import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CartNullPage extends StatefulWidget {
  @override
  _CartNullPageState createState() => _CartNullPageState();
}

class _CartNullPageState extends State<CartNullPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Builder(
        builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[createHeader()],
                ),
                flex: 50,
              ),
            ],
          );
        },
      ),
    );
  }

  createHeader() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 160,
            margin: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("https://thietbivesinhsonanh.com/Content/images/empty-cart.png"),fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}