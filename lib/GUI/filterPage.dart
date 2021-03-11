import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/maindrawer.dart';
import 'package:login_sigup_flutter/Helper/api.services.dart';
import 'dart:async';
import 'package:login_sigup_flutter/Model/user.dart';


class UserFilterDemo extends StatefulWidget {
  UserFilterDemo() : super();

  final String title = "LIST USER";

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserFilterDemoState extends State<UserFilterDemo> {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  final _debouncer = Debouncer(milliseconds: 100);
  List<User> users = List();
  List<User> filteredUsers = List();


  @override
  void initState() {
    super.initState();
    APIService.fetchUser().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer:
        MainDrawer(),
      body:

      RefreshIndicator(
        onRefresh: refreshList,
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12.0),
                icon: Icon(Icons.search),
                hintText: 'Enter the name you want to search?',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    filteredUsers = users
                        .where((u) => (u.fullName
                        .toLowerCase()
                        .contains(string.toLowerCase())))
                        .toList();
                  });
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  if(users == null){
                    return Center(child: CircularProgressIndicator(),);
                  }else{
                    return Card(
                        child: ListTile(title : Text(filteredUsers[index].fullName),
                          subtitle: Text("${filteredUsers[index].email}"),
                          trailing: GestureDetector(
                            child: Icon(Icons.delete, color: Colors.red,size: 25,),
                            onTap: (){
                              confirmDeleteDialog(context, "Are you sure you want to delete.","${filteredUsers[index].id}");
                            },
                          ),
                        )
                    );
                  }
                },
              ),
            ),
          ],
        ),

      ),

    );
  }

  void _showMessageSuccess() {
    final snack = SnackBar(
      content: Text("Delete successed."),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    _globalKey.currentState.showSnackBar(snack);
  }

  confirmDeleteDialog(BuildContext context, String title, String id) {
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
                _showMessageSuccess();
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

  Future<Null> refreshList() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      filteredUsers = users;
    });
  }
}