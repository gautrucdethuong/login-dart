import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/Animation/LoadingError.dart';
import 'package:login_sigup_flutter/GUI/loginscreeen.dart';
import 'package:login_sigup_flutter/GUI/userdetails.dart';
import 'package:login_sigup_flutter/Helper/api.services.dart';
import 'package:login_sigup_flutter/Model/user.dart';



class HomePage extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}


class _MyApp2State extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LIST USER"), centerTitle: true, backgroundColor: Colors.purple,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.logout), onPressed: () async{
          //RestarApp.restartApp(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()));
        }
        ),
      ],
      ),
      body: Container(
        child: FutureBuilder(
          future: APIService.fetchUser(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
            if (snapshot.hasData) {
              List<User> posts = snapshot.data;
              return ListView(
                children: posts
                    .map(
                      (User post) => ListTile(
                    title: Text(post.fullName),
                    subtitle: Text("${post.email}"),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserDetail(
                          user: post,
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              );
            } else {
              //return Center(child: CircularProgressIndicator());
              return ShimmerList();
            }
          },
        ),
      ),
    );
  }

}


