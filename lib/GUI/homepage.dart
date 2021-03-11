import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/loginscreeen.dart';
import 'package:login_sigup_flutter/GUI/maindrawer.dart';
import 'package:login_sigup_flutter/GUI/userdetails.dart';
import 'package:login_sigup_flutter/Helper/api.services.dart';
import 'package:login_sigup_flutter/Model/user.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  Future<Null> refreshData() async{
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a, b, c) => HomePage(),
        transitionDuration:  Duration(seconds: 2)));
  }
  void showMessageSuccess() {
    final snack = SnackBar(
      content: Text("Delete successed."),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    _globalKey.currentState.showSnackBar(snack);
  }
  void confirmDeleteDialog(BuildContext context, String title, String id) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(title),
            //content: Text(text),
            actions: <Widget>[
              new FlatButton(onPressed: (){
                APIService.deleteUser(id);
                Navigator.of(context).pop();
                showMessageSuccess();
              },
                child: Text("OK"),color: Colors.black12,textColor: Colors.green,),

              new FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
                child: Text("Cancel"),color: Colors.black12,textColor: Colors.green,),
            ],
          ),
    );
  }
  Widget buildListView(){
    return FutureBuilder(
      future: APIService.fetchUser(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
        if (snapshot.hasData) {
          List<User> posts = snapshot.data;
          return ListView(
            children: posts.map((User post) {
              return Card(
                  child: ListTile(title : Text(post.fullName),
                    subtitle: Text(post.email),
                    onLongPress: (){
                      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDetail(user: post)));
                    },
                    trailing: GestureDetector(
                      child: Icon(Icons.delete, color: Colors.red,size: 25,),
                      onTap: (){
                        confirmDeleteDialog(context, "Are you sure you want to delete.","${post.id}");
                      },
                    ),
                  )
              );
            },
            )
                .toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
          //return ShimmerList();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(title: Text("MY HOME PAGE"), centerTitle: true, backgroundColor: Colors.redAccent,
      ),
      drawer:MainDrawer(),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: Colors.blue,
        child: buildListView(),
      ),
    );
  }
}


