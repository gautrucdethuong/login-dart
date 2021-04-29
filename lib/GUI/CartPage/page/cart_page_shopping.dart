import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/CartPage/page/app_bar.dart';
import 'package:login_sigup_flutter/GUI/CartPage/theme/Colors.dart';
import 'package:login_sigup_flutter/Helper/CartService.dart';
import 'package:login_sigup_flutter/Helper/ProductService.dart';
import 'package:login_sigup_flutter/Model/cart.dart';
import 'package:login_sigup_flutter/Model/product.dart';
import 'cart_null_page.dart';
import 'method_checkout_page.dart';



class CartShopPage extends StatefulWidget {
  @override
  _CartShopPageState createState() => _CartShopPageState();
}

class _CartShopPageState extends State<CartShopPage> {

  Future<Null> refreshData() async{
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a, b, c) => CartShopPage(),
        transitionDuration:  Duration(seconds: 2)));
  }

  Widget buildListView(){
    return FutureBuilder(
      future: APICart.fetchCartByIdUser(),
      builder: (BuildContext context, AsyncSnapshot<List<Cart>> snapshot){
        if (snapshot.hasData) {
          List<Cart> posts = snapshot.data;
          return ListView(
            children: posts.map((Cart post) {
              return FutureBuilder(
                future: APIProduct.getProductDetail(post.productId),
                builder: (BuildContext context, AsyncSnapshot<Product> snapshot){
                  if (snapshot.hasData) {
                    Product product = snapshot.data;
                    return Column(
                      children: <Widget>[
                        FadeInDown(
                          duration: Duration(milliseconds: 350 * 5),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, bottom: 30),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: grey,
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 0.5,
                                            color: black.withOpacity(0.1),
                                            blurRadius: 1)
                                      ],
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8, top: 8, bottom: 8),
                                    child: Column(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            width: 100,
                                            height: 110,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        product.productImage),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          product.productName,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Size: " + product.productSize,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "\$ " + product.productPrice.toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                color: Colors.green

                                              ),
                                            ),
                                            Text(
                                              "x " + post.quantity.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey

                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                               // CartCounter(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }else{
                    return Center(child: CircularProgressIndicator());
                    //return CartNullPage();
                  }
                },
              );
            },
            )
                .toList(),
          );
        } else {
          return CartNullPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: getAppBar(context),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: Colors.blue,
        child: buildListView(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          return Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CheckoutOnePage()));
        },
        icon: Icon(Icons.money),
        label: Text("Check out"),
        backgroundColor: Colors.red,
      ),
    );
  }
}


