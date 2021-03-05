import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/Model/user.dart';

class UserDetail extends StatelessWidget {
  final User user;

  UserDetail({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(user.fullName),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("Email Address"),
                        subtitle: Text(user.email),
                      ),
                      ListTile(
                        title: Text("Phone Number"),
                        subtitle: Text("${user.phoneNumber}"),
                      ),
                      ListTile(
                        title: Text("Username"),
                        subtitle: Text(user.username),
                      ),
                      ListTile(
                        title: Text("Password"),
                        subtitle: Text(user.password),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}