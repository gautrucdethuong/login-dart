import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/CartPage/page/app_bar.dart';
import 'package:login_sigup_flutter/GUI/CartPage/theme/Colors.dart';
import 'package:login_sigup_flutter/Helper/CartService.dart';
import 'package:login_sigup_flutter/Helper/ProductService.dart';
import 'package:login_sigup_flutter/Helper/ReviewService.dart';
import 'package:login_sigup_flutter/Helper/UserService.dart';
import 'package:login_sigup_flutter/Model/cart.dart';
import 'package:login_sigup_flutter/Model/product.dart';
import 'package:login_sigup_flutter/Model/review.dart';
import 'maindrawer.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  Future<Null> refreshData() async{
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a, b, c) => HomePage(),
        transitionDuration:  Duration(seconds: 2)));
  }

  confirmDeleteDialog(BuildContext context, String id) {
    confirmationDialog(context, "Are you sure you want to delete member ?", positiveText: "Delete", positiveAction: (){
      APIService.deleteUser(id);
    }, confirm: false, title: "Are you sure?",icon: AlertDialogIcon.WARNING_ICON);
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
                                          top: 10,
                                          left: 25,
                                          right: 25,
                                          bottom: 25),
                                      child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 85,
                                              height: 100,
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
                                                fontSize: 16,
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
                                                "\$ " + product.productPrice.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }
                  },
              );

            },
            ).toList(),
          );
        } else {
          return Center(child: loadingScreen(context, loadingType: LoadingType.JUMPING));
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      //drawer:MainDrawer(),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: Colors.blue,
        child: buildListView(),
      ),
      floatingActionButton: FloatingActionButton(

      ),
    );
  }
}


