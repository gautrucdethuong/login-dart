import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:commons/commons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/LoginPage/User/loginscreeen.dart';

class VerificationOTPPage extends StatefulWidget {
  @override
  _VerificationOTPPageState createState() => _VerificationOTPPageState();
}

class _VerificationOTPPageState extends State<VerificationOTPPage> {

  bool visible = false;
  final _otpController = TextEditingController();

  // method call api verify OTP
  verificationOTPUser(String otp) async {
    setState(() {
      visible = true;
    });
    String body = jsonEncode(<String, String>{
      'otp' : otp,
    });
    final response = await http.Client().post(
      'http://10.0.2.2:5000/api/OTPSender/verify/',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );

    final repoData = json.decode(response.body);
    final parsed = repoData['result'];

    if(response.statusCode == 200){
      if( parsed == "Successed."){
        successDialog(context, "Verification successful. Comeback Login.");
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });

      }else{
        setState(() {
          visible = false;
        });
        warningDialog(context, "Code OTP incorrect.");
      }
    }else{
      errorDialog(context, "Please enter your OTP code.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Forgot password'),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Please enter OTP code.',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    )),
                SizedBox(width: 30,),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _otpController,
                    maxLength: 6,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'G- Code',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Verify'),
                      onPressed: () async {
                        await verificationOTPUser(_otpController.text);
                      },
                    )),
              ],
            )));
  }
}


