import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/LoginPage/User/loginscreeen.dart';
import 'package:login_sigup_flutter/GUI/LoginPage/User/signup.dart';
import 'package:login_sigup_flutter/GUI/Service/User/senderotp.dart';
import 'package:login_sigup_flutter/GUI/Service/User/senderotpSMS.dart';


class WelcomePage extends StatefulWidget{
  @override
  _WelcomePageState createState()=> _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>{

  Widget buildForgotPassword(){
    return FlatButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SenderOTPPage()));
        },
        textColor: Colors.blue,
        child: Text('Forgot Password'),
    );
  }
  Widget buildFacebookBtn(){
    return Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text('Login with Facebook', style: TextStyle(fontSize: 17),),
          onPressed: () {
            /*Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()));*/
          },
        )
    );
  }
  Widget buildSMSBtn(){
    return Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text('Login with SMS', style: TextStyle(fontSize: 17),),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SenderOTPPageSMS()));

          },
        )
    );
  }
  Widget buildAccountBtn(){
    return Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text('Login with Account Shopping', style: TextStyle(fontSize: 17),),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        )
    );
  }
  Widget buildRegisterBtn(){
    return Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text('Register now', style: TextStyle(fontSize: 17),),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
        )
    );
  }
  Widget buildTitleBtn(){
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          'Shopping app',
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
              fontSize: 30),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                buildTitleBtn(),
                SizedBox(height: 50),
                buildFacebookBtn(),
                SizedBox(height: 10),
                buildSMSBtn(),
                SizedBox(height: 10),
                buildAccountBtn(),
                SizedBox(height: 10,),
                buildForgotPassword(),
                SizedBox(height: 120),
                FlatButton(
                  textColor: Colors.black,
                  child: Text('Does not have account?'),
                ),
                SizedBox(height: 10),
                buildRegisterBtn(),
              ],
            )));
  }
}

