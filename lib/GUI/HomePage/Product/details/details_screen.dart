import 'dart:convert';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_sigup_flutter/GUI/CartPage/page/cart_page_shopping.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/constants.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/home/home_screen.dart';
import 'package:login_sigup_flutter/Helper/CartService.dart';
import 'package:login_sigup_flutter/Helper/ProductService.dart';
import 'package:login_sigup_flutter/Model/product.dart';
import 'components/body.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:http/http.dart' as http;


class DetailsScreen extends StatelessWidget {

  final Product product;
  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: buildAppBar(context),
      ),
      body: Body(product: product),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog(
              context: context,
              barrierDismissible: true, // set to false if you want to force a rating
              builder: (context) {
                return RatingDialog(
                  icon: const FlutterLogo(size: 50,), // set your own image/icon widget
                  title: "What is you rate?",
                  description: "Please share your opinion about the product",
                  submitButton: "SEND REVIEW",
                  alternativeButton: "Contact us instead?", // optional
                  positiveComment: "We are so happy to hear ❤", // optional
                  negativeComment: "We're sad to hear 💔", // optional
                  accentColor: Colors.yellowAccent[400], // optional
                  onSubmitPressed: (int rating) async {

                    int id = await APIProduct.getIdUserLogin();
                    String body = jsonEncode(<String, String>{
                      'userId': id.toString(),
                      'productId': product.id.toString(),
                      'rating': rating.toString(),
                    });
                    final response = await http.Client().post(
                      'http://10.0.2.2:5000/api/Review/',
                      headers: <String, String>{
                        'Content-Type': 'application/json',
                      },
                      body: body,
                    );

                    final repoData = json.decode(response.body);
                    final parsed = repoData['result'];

                    if (response.statusCode == 200) {
                      if (parsed == "Successed.") {
                        successDialog(context, "Post successfully");
                      } else {
                        warningDialog(context, "You reviewed. Not review");
                      }
                    } else {
                      errorDialog(context,
                          "No internet connection. Connect to the internet and try again.");
                    }
                  },
                  onAlternativePressed: () {
                    print("onAlternativePressed: do something");
                    // TODO: maybe you want the user to contact you instead of rating a bad review
                  },
                );
              }
              );
        },
        icon: Icon(Icons.widgets_rounded),
        label: Text("Write a review"),
        backgroundColor: Colors.red,
      ),
    );
  }



  Widget buildAppBar(context){
    return FutureBuilder(
      future: APICart.countProductByCart(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot ){
          if(snapshot.hasData) {
            int count = snapshot.data;
            return AppBar(
              elevation: 0,
              backgroundColor: Colors.blue,
              leading: IconButton(icon: SvgPicture.asset("assets/icons/back.svg"),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CartShopPage()));
                },
              ),
              actions: <Widget>[
                IconButton(icon: SvgPicture.asset("assets/icons/search.svg"), onPressed: (){}),
                IconButton(icon: Container(
                  child: Center(
                    child: Text(count.toString() ,style: TextStyle(
                        color: white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  decoration: BoxDecoration(
                      color: black,
                      shape: BoxShape.circle
                  ),
                ), onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                }),
              ],
            );
          }else{
            return Center(child: Text("LOADING..."),);
          }
      }
    );
  }
}
