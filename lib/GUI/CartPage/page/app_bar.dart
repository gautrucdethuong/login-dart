import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_sigup_flutter/GUI/CartPage/theme/Colors.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/home/home_screen.dart';
import 'package:login_sigup_flutter/Helper/CartService.dart';
import 'cart_page_shopping.dart';



Widget getAppBar(context){
  return FutureBuilder(
    future: APICart.countProductByCart(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot){
      if(snapshot.hasData){
        int count = snapshot.data;
        return AppBar(
          elevation: 0,
          backgroundColor: white,
          leading: IconButton(icon: SvgPicture.asset("assets/icons/back.svg"),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
            },
          ),
          actions: <Widget>[
            IconButton(icon: SvgPicture.asset("assets/icons/search.svg"), onPressed: (){}),
            IconButton(icon: Container(
              child: Center(
                child: Text(count.toString(),style: TextStyle(
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CartShopPage()));
            }),

          ],
        );
      }else{
        return Center(child: Text("LOADING..."));
      }
      }
  );
}


