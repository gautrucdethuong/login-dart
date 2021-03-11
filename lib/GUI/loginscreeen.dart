import 'dart:convert';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_sigup_flutter/GUI/filterPage.dart';
import 'package:login_sigup_flutter/GUI/signup.dart';
import 'package:login_sigup_flutter/Helper/api.services.dart';
import 'package:login_sigup_flutter/Model/user.dart';
import 'homepage.dart';
import 'resetpasscreen.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState()=> _LoginScreenState();
  }

class _LoginScreenState extends State<LoginScreen>{

  bool visible = false ;
  bool isRememberMe = true;
  final  usernameController = new TextEditingController();
  final  passwordController = new TextEditingController();

  // widget
  Widget buildUsername(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Text('Username', style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: new TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: usernameController,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email, color: Colors.red,
                ),
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )

            ),
          ),
        )
      ],
    );
  }
  Widget buildPassword(){
    return Column(
      // cung cấp các hằng số dùng để căng chỉnh
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Password', style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextFormField(
            obscureText: true, // dung de che khuat cac ki tu van ban
            style: TextStyle(color: Colors.black87,
            ),
            controller: passwordController,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock, color: Colors.red,
                ),
                hintText: 'Password', // style password
                hintStyle: TextStyle(
                  color: Colors.black26,
                )

            ),
          ),
        )

      ],
    );
  }
  Widget buildForgetPassBtn(){
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
        },
        padding: EdgeInsets.only(right: 0),
        child: Text(
          'Forgot Password ?',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
  Widget buildRememberCbb(){
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value){
                setState(() {
                  isRememberMe = value;
                });
              },
            ),
          ),
          Text('Remember me',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
  Widget buildLoginBtn(){
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child:
        RaisedButton(
          elevation: 5,
          onPressed: () async{
            setState(() {
              if(usernameController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty){
                Login(usernameController.text,passwordController.text);
              }else{
                displayDialog(context, "Username and password required.", "","Cancel");
              }
            });
          },
          padding: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          color: Colors.white,
          child: Text(
            'LOGIN', style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          ),
        )
    );
  }
  Widget buildSignupBtn(){
    return GestureDetector(
      child: RaisedButton(
        child: Text('Sign Up',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => signup()), // chuyen new page
          );
        },
      ),
    );
  }

    //login
   Future<User> Login(String username, String password) async {

    setState(() {
      visible = true ;
    });

    String body = convert.jsonEncode(<String, String>{
      'username': username,
      'password': password,
    });

    final response = await http.Client().post('http://10.0.2.2:5000/api/Token/login',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );

    final repoData = json.decode(response.body);
    final parsed = repoData['result'];

    if(response.statusCode == 200){
      // check status login
      if(parsed == "Successed."){
        String token = repoData['data']['token'];

        APIService.setToken(token);
        //APIService.read(parsed);

        setState(() {
          visible = false;
        });

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage())
        );
      }else{

        setState(() {
          visible = false;
        });
            displayDialog(context, "No account was found matching that username and password.", "", "Try again");
      }
    }else{
      throw Exception('Failed to load Data');
    }
  }


    // show status message
   displayDialog(BuildContext context, String title, String text, String confirm) {
     showDialog(
       context: context,
       builder: (context) =>
           CupertinoAlertDialog(
             title: Text(title),
             content: Text(text),
             actions: <Widget>[
               FlatButton(onPressed: (){
                 Navigator.of(context).pop();
               },
                   child: CupertinoDialogAction(child: Text(confirm)))
             ],
           ),
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector( // thu thap du lieu tren man hinh
          child: Stack(
            children:<Widget> [
              Container(
                height: double.infinity,
                width: double.infinity,
                // background khung man hinh
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x6600BBEE),
                      Color(0x9900BBEE),
                      Color(0xcc00BBEE),
                      Color(0xff00BBEE),
                    ]
                  )
                ),
                child: SingleChildScrollView(

                  physics: AlwaysScrollableScrollPhysics(),// tao thanh cuon
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Text('User Login', style: TextStyle(
                        color: Colors.pink, fontSize: 40, fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(height: 50),
                      buildUsername(),
                      SizedBox(height: 20),
                      buildPassword(),
                      //buildRememberCbb(),
                      buildForgetPassBtn(),
                      buildLoginBtn(),
                      buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

