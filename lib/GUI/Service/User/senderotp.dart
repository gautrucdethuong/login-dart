import 'dart:convert';
import 'package:commons/commons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_sigup_flutter/GUI/Verification/verificationotp.dart';


class SenderOTPPage extends StatefulWidget {
  @override
  _SenderOTPPageState createState() => _SenderOTPPageState();
}

class _SenderOTPPageState extends State<SenderOTPPage> {

  bool visible = false ;
  final _phoneController = TextEditingController();
  // method call api send otp
  SenderOTPUser(String phone) async {
    setState(() {
      visible = true ;
    });

    String body = jsonEncode(<String, String>{
      'phone': phone,
    });
    final response = await http.Client().post('http://10.0.2.2:5000/api/OTPSender/sender/',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );
    final repoData = json.decode(response.body);
    final parsed = repoData['result'];

    if(response.statusCode == 200){
      if(parsed == "Successed."){
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => VerificationOTPPage())
          );
        });
      }else{
        setState(() {
          visible = false ;
        });
        warningDialog(context, "Phone number is not register.");
      }
    }else{
      errorDialog(context, "No internet connection. Connect to the internet and try again.");
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
                      'Please enter the phone number you registered at my app.',
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _phoneController,
                    validator: (value){
                      if(value.isEmpty || value.length > 11){
                        return "Phone number can't be empty and contain 10 digits.";
                      }
                      if(!RegExp("^\\+?(0|84)\\d{9}|^\\d{11}").hasMatch(value)){
                        return 'Enter a valid phone number.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone number',
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
                      child: Text('Continue'),
                      onPressed: () async {
                        await SenderOTPUser(_phoneController.text);
                      },
                    )),
              ],
            )));
  }
}


