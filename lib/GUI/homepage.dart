import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/Helper/api.services.dart';
import 'package:login_sigup_flutter/Model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';



class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}


class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LIST USER"), centerTitle: true, backgroundColor: Colors.blue,),
      body: Container(
        child: FutureBuilder<List<User>>(
          future: APIService.fetchUser(),
          builder: (context, snapshot){
            if(snapshot.data == null){
              return Container(child: Center(child: Text("Loading...."),),);
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      subtitle: Text(snapshot.data[index].phoneNumber),
                      title: Text(snapshot.data[index].fullName),

                    );
                },
              );
            }
          },
        ),
      ),
    );
  }
}


