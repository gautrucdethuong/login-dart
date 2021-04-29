import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/constants.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/details/details_screen.dart';
import 'package:login_sigup_flutter/GUI/Service/User/maindrawer.dart';
import 'package:login_sigup_flutter/Helper/ProductService.dart';
import 'package:login_sigup_flutter/Model/product.dart';

import 'categorries.dart';


class SellerPage extends StatefulWidget {
  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {

  Future<Null> refreshData() async{
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a, b, c) => SellerPage(),
        transitionDuration:  Duration(seconds: 2)));
  }
  Widget buildAppBar() {
    return AppBar(
      title: Align(child: Text("Shopertino", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),), alignment: Alignment.center,),
      backgroundColor: Colors.grey[200],
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
  Widget buildBody (){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: buildListView(),
          ),
        ),
      ],
    );
  }
  Widget buildListView(){
    return FutureBuilder(
        future: APIProduct.fetchSeller(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    Product product = snapshot.data[index];
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  product.productImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(product.productName),
                            subtitle: Text(product.productPrice.toString() + " USD"),
                            onTap: (){
                              Navigator.push(context,  MaterialPageRoute(builder: (context) => DetailsScreen(product: snapshot.data[index],),));
                            },
                          )
                        ]);
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: Colors.blue,
        child: buildBody(),
      ),
      drawer: MainDrawer(),
    );
  }
}


