import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_sigup_flutter/GUI/loginscreeen.dart';
import 'package:login_sigup_flutter/Helper/api.services.dart';
import 'package:login_sigup_flutter/Model/user.dart';
import 'package:http/http.dart' as http;


class signup extends StatefulWidget {

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {

  Future<User> futureUsers;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  Widget buildEmail(){
    return Column(
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
            maxLength: 32,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String value){
              if(value.isEmpty){
                return "Please enter email.";
              }
              if(!RegExp("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}").hasMatch(value)){
                return 'Enter a valid email address';
              }
                return null;
            },

            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email, color: Colors.red,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )
            ),
          ),
        )

      ],
    );
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
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: usernameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 15,
            validator: (value){
              if(value.isEmpty){
                return "Username can't be empty.";
              }else if(!RegExp("^[a-z0-9_-]{3,16}").hasMatch(value)){
                return "Username at least 3 characters.";
              }
              return null;
            },
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
            obscureText: true,
            controller: passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 50,
            validator: (value){
              if(value.isEmpty){
                return "Password can't be empty.";
              }else if(!RegExp("^.*(?=.{8,})(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!*@#%^&+=]).*").hasMatch(value)){
                return "Password very bad, at least 8 characters.";
              }
                return null;
            },
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock, color: Colors.red,
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )

            ),
          ),
        )

      ],
    );
  }
  Widget buildConfirmPass(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Confirm Password', style: TextStyle(
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
            obscureText: true,
            controller: confirmPasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 50,
            validator: (value){
              if(value.isEmpty){
                return "Confirm password can't empty.";
              }else if(value != passwordController.text){
                return "Password confirmation must match";
              }
              return null;
            },
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock_clock, color: Colors.red,
                ),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildFullname(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Full Name', style: TextStyle(
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
            keyboardType: TextInputType.name,
            controller: fullNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value.isEmpty){
                return "Full name can't be empty.";
              }else if(!RegExp("^[a-z A-Z]+").hasMatch(value)){
                return "Full name at least 2 words.";
              }

              return null;
            },
            textCapitalization: TextCapitalization.characters,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.drive_file_rename_outline, color: Colors.red,
                ),
                hintText: 'Full Name',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildPhone(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Number Phone', style: TextStyle(
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
            keyboardType: TextInputType.name,
            controller: phoneController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value.isEmpty){
                return "Phone number can't be empty.";
              }
              if(!RegExp("^\\d{10}|^\\d{11}").hasMatch(value)){
                return 'Enter a valid phone number';
              }
                return null;
            },
            maxLength: 12,
            textCapitalization: TextCapitalization.characters,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.phone_callback, color: Colors.red,
                ),
                hintText: 'Number Phone',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )

            ),
          ),
        )

      ],
    );
  }
  Widget buildSignUpBtn(){
    return Container(
      key: _scaffoldKey,
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: (futureUsers == null) ?
      RaisedButton(
        elevation: 5,
        onPressed: () async{
            setState(() {
          futureUsers = APIService.createUser(usernameController.text,passwordController.text,fullNameController.text,emailController.text,phoneController.text);
          //_scaffoldKey.currentState.showSnackBar(snackBar);
            });
        },
        padding: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Text(
          'SIGN UP', style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
        ),
      ) : FutureBuilder<User>(
          future: futureUsers,
          builder: (context, snapshot){
            if(snapshot.hasData){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
              });
            }else if(snapshot.hasError){
              return Center(child: CircularProgressIndicator(),);
            }
            return Center(child: CircularProgressIndicator(),);
          })
    );
  }

  final snackBar = SnackBar(content: Text("Register Successed.", style: TextStyle(
    fontSize: 16,),),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.green,
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        //leadingWidth: 10,
        toolbarHeight: 40,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
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

                  physics: AlwaysScrollableScrollPhysics(), // tao thanh cuon
                  padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Text('Register', style: TextStyle(
                        color: Colors.pink, fontSize: 40, fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(height: 10),
                      buildFullname(),
                      SizedBox(height: 10),
                      buildEmail(),
                      SizedBox(height: 10),
                      buildUsername(),
                      SizedBox(height: 10),
                      buildPhone(),
                      SizedBox(height: 10),
                      buildPassword(),
                      SizedBox(height: 10),
                      buildConfirmPass(),
                      SizedBox(height: 10),
                      buildSignUpBtn(),
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
