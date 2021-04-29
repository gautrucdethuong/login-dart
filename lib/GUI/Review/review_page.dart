import 'dart:async';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login_sigup_flutter/Helper/ReviewService.dart';
import 'package:login_sigup_flutter/Helper/UserService.dart';
import 'package:login_sigup_flutter/Model/product.dart';
import 'package:login_sigup_flutter/Model/review.dart';
import 'package:login_sigup_flutter/Model/user.dart';


class ReviewPage extends StatefulWidget {

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  Future<Null> refreshData() async{
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a, b, c) => ReviewPage(),
        transitionDuration:  Duration(seconds: 2)));
  }

  Widget buildListView(){
    return FutureBuilder(
      future: APIReview.fetchReviewByIdProduct(2),
      builder: (BuildContext context, AsyncSnapshot<List<Review>> snapshot){
        if (snapshot.hasData) {
          List<Review> posts = snapshot.data;
          return ListView(
            children: posts.map((Review post) {
              return FutureBuilder(
                  future: APIService.getUserDetailReview(post.review_UserId),
                  builder: (BuildContext context, AsyncSnapshot<User> snapshot){
                    if (snapshot.hasData) {
                      User user = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.white,
                              elevation: 5,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(radius: 40.5, backgroundImage: NetworkImage(user.avatar), ),
                                    title: Text(user.fullName, style: const TextStyle(color: Colors.black, fontSize: 20)),
                                    subtitle: RatingBar.builder(
                                      initialRating: double.tryParse(post.review_Rating.toString()),
                                      itemSize: 20,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text('EDIT'),
                                        onPressed: () {  },
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        child: const Text('REPORT'),
                                        onPressed: () {  },
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      );
                    }else{
                      return Center(child: Text("Loading..."),);
                    }
                  }
              );
            },
            )
                .toList(),
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
      appBar: AppBar(title: Text("LIST REVIEWS"), centerTitle: true, backgroundColor: Colors.blue,),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: Colors.blue,
        child: buildListView(),
      ),
    );
  }
}


