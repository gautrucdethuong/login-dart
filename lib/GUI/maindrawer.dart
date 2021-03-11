import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/updateprofile.dart';
import 'package:login_sigup_flutter/GUI/userdetails.dart';
import 'package:login_sigup_flutter/Helper/api.services.dart';
import 'package:login_sigup_flutter/Model/user.dart';

import 'loginscreeen.dart';

class MainDrawer extends StatelessWidget {
  final User user;

  MainDrawer({@required this.user});



  Widget buildHeaderDrawer(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: Colors.redAccent,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://cdn2.vectorstock.com/i/1000x1000/81/96/dog-collection-shih-tzu-geometric-avatar-icon-vector-23218196.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text("ADMIN", style: TextStyle(fontSize: 22, color: Colors.white),),
            Text("admin@gmail.com", style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          buildHeaderDrawer(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile", style: TextStyle(fontSize: 18),),
            onTap: (){
             // APIService.getUserDetails(id);
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Setting", style: TextStyle(fontSize: 18),),
            onTap: (){
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout", style: TextStyle(fontSize: 18),),
            onTap: () async{
              APIService.removeToken();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) =>
                  LoginScreen()), (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
