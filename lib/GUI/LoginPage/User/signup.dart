import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:commons/commons.dart';
import 'loginscreeen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool visible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Widget buildListBody() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
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
                  ])),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(), // tao thanh cuon
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    buildFullName(),
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
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
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
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter email.";
              }
              if (!RegExp("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}")
                  .hasMatch(value)) {
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
                  Icons.email,
                  color: Colors.red,
                ),
                hintText: 'example@email.com...',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )),
          ),
        )
      ],
    );
  }

  Widget buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: TextStyle(
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
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: usernameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty) {
                return "Username can't be empty.";
              } else if (!RegExp("^[a-z0-9_-]{3,16}").hasMatch(value)) {
                return "Username at least three characters.";
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
                  Icons.email,
                  color: Colors.red,
                ),
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
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
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            obscureText: true,
            controller: passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty) {
                return "Password can't be empty.";
              } else if (!RegExp(
                      "^.*(?=.{8,})(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!*@#%^&+=]).*")
                  .hasMatch(value)) {
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
                  Icons.lock,
                  color: Colors.red,
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )),
          ),
        )
      ],
    );
  }

  Widget buildConfirmPass() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: TextStyle(
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
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            obscureText: true,
            controller: confirmPasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty) {
                return "Confirm password can't empty.";
              } else if (value != passwordController.text) {
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
                  Icons.lock_clock,
                  color: Colors.red,
                ),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )),
          ),
        )
      ],
    );
  }

  Widget buildFullName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: TextStyle(
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
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: fullNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty) {
                return "Full name can't be empty.";
              } else if (!RegExp("^[a-z A-Z]+").hasMatch(value)) {
                return "Full name at least two words.";
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
                  Icons.drive_file_rename_outline,
                  color: Colors.red,
                ),
                hintText: 'Full Name',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )),
          ),
        )
      ],
    );
  }

  Widget buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone Number, max length 11 digit',
          style: TextStyle(
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
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: phoneController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty || value.length > 11) {
                return "Phone number can't be empty and contain 10 digits.";
              }
              if (!RegExp("^\\+?(0|84)\\d{9}|^\\d{11}").hasMatch(value)) {
                return 'Enter a valid phone number';
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
                  Icons.phone_callback,
                  color: Colors.red,
                ),
                hintText: '(+84) Phone number.',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )),
          ),
        )
      ],
    );
  }

  Widget buildSignUpBtn() {
    return Container(
        key: _scaffoldKey,
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5,
          onPressed: () async {
            createUser(
                usernameController.text,
                passwordController.text,
                fullNameController.text,
                emailController.text,
                phoneController.text);
          },
          padding: EdgeInsets.all(5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Text(
            'SIGN UP',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ));
  }

  //method call api create user
  createUser(String username, String password, String fullName, String email,
      String phoneNumber) async {
    setState(() {
      visible = true;
    });
    String body = jsonEncode(<String, String>{
      'user_username': username,
      'user_password': password,
      'user_fullname': fullName,
      'user_email': email,
      'user_phone': phoneNumber,
    });
    final response = await http.Client().post(
      'http://10.0.2.2:5000/api/user',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );

    final repoData = json.decode(response.body);
    final parsed = repoData['result'];

    if (response.statusCode == 200) {
      if (parsed == "Successed.") {
        successDialog(context, "You have signed up successfully");
        // 5s over, navigate to a new page
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        });
      } else {
        setState(() {
          visible = false;
        });
        warningDialog(context, "Username is already.");
      }
    } else {
      errorDialog(context,
          "No internet connection. Connect to the internet and try again.");
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
