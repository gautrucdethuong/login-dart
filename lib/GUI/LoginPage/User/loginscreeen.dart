import 'dart:convert';
import 'dart:convert' as convert;
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_sigup_flutter/Helper/UserService.dart';
import '../../HomePage/Product/home/home_screen.dart';
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

  // widget build
  Widget buildErrorConnection(){
    return errorDialog(context, "No internet connection. Connect to the internet and try again.", negativeText: "Try Again", negativeAction: (){
      waitDialog(context,duration: Duration(minutes: 3), message: "Please waiting...");
    },neutralText: "Okay", neutralAction: (){
    },icon: AlertDialogIcon.WIFI_OFF_ICON, title: "No network connection");
  }
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
                loginPage(usernameController.text,passwordController.text);
              }else{
                warningDialog(context, "Username and password required.",);
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

  Widget buildListBody(){
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                    Text('Welcome back!', style: TextStyle(
                      color: Colors.red[600], fontSize: 40, fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(height: 50),
                    buildUsername(),
                    SizedBox(height: 20),
                    buildPassword(),
                    //buildRememberCbb(),
                    buildLoginBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //method login
   loginPage(String username, String password) async {
    setState(() {
      visible = true ;
    });

    String body = convert.jsonEncode(<String, String>{
      'username': username,
      'password': password,
    });

    final response = await http.Client().post('http://10.0.2.2:5000/api/AuthenManager/login',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );

    final repoData = json.decode(response.body);
    final parsed = repoData['result'];

    if(response.statusCode == 200){
      if(parsed == "Successed."){
        String token = repoData['data']['user_token'];
        int user_id = repoData['data']['user_id'];

        APIService.setToken(token);
        APIService.setIdUserLogin(user_id);


        setState(() {
          visible = false;
        });

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen())
        );
      }else{

        setState(() {
          visible = false;
        });
            warningDialog(context, "No account was found matching that username and password.", icon: AlertDialogIcon.WARNING_ICON);
      }
    }else{
      buildErrorConnection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        toolbarHeight: 40,
      ),
      body: buildListBody(),

    );
  }
}

