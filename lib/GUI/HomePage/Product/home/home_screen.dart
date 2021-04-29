import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_sigup_flutter/GUI/CartPage/page/cart_page.dart';
import 'package:login_sigup_flutter/GUI/CartPage/page/cart_page_shopping.dart';
import 'package:login_sigup_flutter/GUI/CartPage/theme/Colors.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/constants.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/details/details_screen.dart';
import 'package:login_sigup_flutter/GUI/Service/User/maindrawer.dart';
import 'package:login_sigup_flutter/Helper/CartService.dart';
import 'package:login_sigup_flutter/Helper/ProductService.dart';
import 'package:login_sigup_flutter/Model/product.dart';
import '../../../Service/User/googlemap.dart';
import 'components/categorries.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: FutureBuilder(
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
                                  ),
                                  RatingBar.builder(
                                    initialRating: double.tryParse(product.productRating),
                                    itemSize: 20,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber,),
                                  ),
                                ]);
                          }),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
            ),
          ),
        ),
      ],
    ),

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: FutureBuilder(
                future: APIProduct.fetchProduct(),
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
                                  ),
                                  RatingBar.builder(
                                    initialRating: double.tryParse(product.productRating),
                                    itemSize: 20,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber,),
                                  ),
                                ]);
                          }),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
            ),
          ),
        ),
      ],
    ),
    MapSample(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  Future<Null> refreshData() async{
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a, b, c) => HomeScreen(),
        transitionDuration:  Duration(seconds: 2)));
  }

  Widget buildAppBar() {
    return FutureBuilder(
      future: APICart.countProductByCart(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot){
          if(snapshot.hasData) {
            int count = snapshot.data;
            return AppBar(
              title: Align(child: Text("Shopertino", style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),), alignment: Alignment.center,),
              backgroundColor: Colors.grey[200],
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/search.svg",
                    color: kTextColor,
                  ),
                  onPressed: () {
                    return TextField(
                      style: TextStyle(color: Colors.black, backgroundColor: Colors.blue),
                    );
                  },
                ),
                IconButton(icon: Container(

                  child: Center(
                    child: Text(count.toString(),style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 13,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xff000000),
                      shape: BoxShape.circle
                  ),
                ), onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CartShopPage()));
                }),
                SizedBox(width: kDefaultPaddin / 2)
              ],
            );
          }else{
            return Center(child: Text("LOADING..."));
          }
        }
    );


  }

  Widget buildListBody(){
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
  Widget buildBody (){
    return Center(

      child: _widgetOptions.elementAt(_selectedIndex),
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
                          ),
                          RatingBar.builder(
                            initialRating: double.tryParse(product.productRating),
                            itemSize: 20,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber,),
                          ),
                        ]);
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
        );
  }

  final List<BottomNavigationBarItem> _listBottomItem = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      title: Text('Shop'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      title: Text('Map'),
    ),
  ];

  Widget buildBottomBar(){
    return BottomNavigationBar(
      unselectedItemColor: Colors.black,
      items: _listBottomItem,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[200],
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: buildAppBar(),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: Colors.blue,
        child: buildBody(),
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: buildBottomBar(),
    );
  }
}


