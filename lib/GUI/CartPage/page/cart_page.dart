import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/constants.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/details/components/counter_with_fav_btn.dart';
import 'package:login_sigup_flutter/Helper/CartService.dart';
import 'package:login_sigup_flutter/Helper/ProductService.dart';
import 'package:login_sigup_flutter/Model/cart.dart';
import 'package:login_sigup_flutter/Model/product.dart';
import 'app_bar.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[
              getAppBar(context),
              buildCreateSubTitle(),
              buildCartList(),
              buildFooter(context)
            ],
          );
        },
      ),
    );
  }

  Widget buildCreateSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text("My Bag",style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600
        ),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }
  Widget buildFooter(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Text(
                  "\$299.00",
                  style: CustomTextStyle.textFormFieldBlack.copyWith(
                      color: Colors.greenAccent.shade700, fontSize: 14),
                ),
              ),
            ],
          ),
         // Utils.getSizedBox(height: 8),
          RaisedButton(
            onPressed: () {

            },
            color: Colors.black,
              padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Text(
              "Checkout",
              style: CustomTextStyle.textFormFieldSemiBold
                  .copyWith(color: Colors.white),
            ),
          ),
         // Utils.getSizedBox(height: 8),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  Widget buildCartList() {
    return FutureBuilder(
      future: APICart.fetchCartByIdUser(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    Cart cart = snapshot.data[index];
                    return FutureBuilder(
                      future: APIProduct.getProductDetail(cart.productId),
                      builder: (BuildContext context, AsyncSnapshot<Product> snapshot){
                        if(snapshot.hasData){
                          Product product = snapshot.data;
                          return Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(14)),
                                          color: Colors.blue.shade200,
                                          image: DecorationImage(
                                              image: NetworkImage(product.productImage))
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(right: 8, top: 4),
                                              child: Text(
                                                product.productName,
                                                maxLines: 2,
                                                softWrap: true,
                                                style: CustomTextStyle.textFormFieldSemiBold
                                                    .copyWith(fontSize: 14),
                                              ),
                                            ),
                                          //  Utils.getSizedBox(height: 6),
                                            Text("Size: " +
                                              product.productSize,
                                              style: CustomTextStyle.textFormFieldRegular
                                                  .copyWith(color: Colors.grey, fontSize: 14),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "\$ " + product.productPrice.toString(),
                                                    style: CustomTextStyle.textFormFieldBlack
                                                        .copyWith(color: Colors.red),
                                                  ),
                                                  CartCounter(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                     // flex: 100,
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 10, top: 8),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      color: Colors.green),
                                ),
                              )
                            ],
                          );
                        }else{
                          return Center(child: loadingScreen(context, loadingType: LoadingType.SCALING));
                        }
                    },
                    );
                  }
              );
          }else{
            return Center(child: loadingScreen(context, loadingType: LoadingType.JUMPING));
          }
        }
    );
  }
}