import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/Welcomepage.dart';
import 'package:login_sigup_flutter/GUI/Service/User/about_page.dart';
import 'package:login_sigup_flutter/GUI/Service/User/invite_friend_page.dart';
import 'package:login_sigup_flutter/GUI/Service/User/updateprofile.dart';
import 'package:login_sigup_flutter/Helper/UserService.dart';
import 'package:login_sigup_flutter/Model/user.dart';
import 'notificationPage.dart';


class MainDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: APIService.getUserDetail(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            User posts = snapshot.data;
            return Drawer(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(posts.avatar),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(posts.fullName, style: TextStyle(fontSize: 22, color: Colors.black),),
                            subtitle: Text("201 Followers"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      "Profile",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () async {
                      return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateProfile(user: posts)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.message_outlined),
                    title: Text(
                      "Notification",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      "Invite Friend",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InviteFriendsPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      "Logout",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () async {
                      APIService.logout(posts.refreshToken, posts.token);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => WelcomePage()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text(
                      "Help and Feedback",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutPage()));
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
                child:
                    loadingScreen(context, loadingType: LoadingType.SCALING));
          }
        });
  }
}
