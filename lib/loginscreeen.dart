import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_sigup_flutter/forgotpassscreen.dart';
import 'package:login_sigup_flutter/homepage.dart';
import 'package:login_sigup_flutter/signupscreen.dart';
import 'resetpasscreen.dart';



class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState()=> _LoginScreenState();

  }

class _LoginScreenState extends State<LoginScreen>{
  bool isRememberMe = false;

  Widget buildEmail(){
    return Column(
      // cung cấp hằng số dùng để căng chỉnh
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Email', style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration( // thêm đường viền
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
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.continueAction,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email, color: Colors.red,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.black,
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
          child: TextField(
            obscureText: true, // dung de che khuat cac ki tu van ban
            style: TextStyle(color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock, color: Colors.red,
                ),
                hintText: 'Password', // style password
                hintStyle: TextStyle(
                  color: Colors.black,
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
      child: RaisedButton(
        elevation: 5,
        onPressed: () => print('Login Pressed'),
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
      ),
    );
  }
  Widget buildSignupBtn(){
    return GestureDetector(
      onTap: (
          ) => print("Sign up Pressed"),

        child: RaisedButton(
            child: Text('Sign Up',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              ),
              ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => signupscreen()), // chuyen new page
            );
      },
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
                      buildEmail(),
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