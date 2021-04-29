import 'package:commons/commons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';



class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {

  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  void sendOTP() async{
    EmailAuth.sessionName = "HUYNH NHAT MINH";
    final res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if(res){
      successDialog(context, "Code OTP has been sent to your email address. Please check your email.", title: "Success");
    }else{
      warningDialog(context, "Try again.");
    }
  }
  void verifyOTP() async{
    final res = EmailAuth.validate(receiverMail: _emailController.text, userOTP: _otpController.text);
    if(res){
      successDialog(context, "Verify succeeded. Change password now!",);
       Future.delayed(const Duration(seconds: 2), (){
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
       });

    }else{
      warningDialog(context, "Invalid OTP code.", title: "Error");
    }
  }

  
  Widget buildVerifyEmail(){
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
            controller: _emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String value){
              if(value.isEmpty){
                return "Please enter email.";
              }
              if(!RegExp("^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
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
                hintText: 'Enter your email address',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )
            ),
          ),
        )

      ],
    );
  }
  Widget buildVerifyOTP(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          child: TextFormField(
            maxLength: 6,
            obscureText: true,
            keyboardType: TextInputType.number,
            controller: _otpController,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.mark_email_read, color: Colors.red,
                ),
                hintText: 'Enter your OTP',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )
            ),
          ),
        )

      ],
    );
  }
  Widget buildSendBtn(){
    return Container(
      width: 100,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          sendOTP();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)
        ),
        child: Text(
          'Send', style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
        ),
        ),
      ),
    );
  }
  Widget buildValidOTPBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: 200,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          verifyOTP();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.deepOrange,
        child: Text(
          'Verify', style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
        ),
      ),
    );
  }
  Widget buildListBody(){
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        child: Stack(
          children:<Widget> [
            Container(
              height: double.infinity,
              width: double.infinity,
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
                    vertical: 80
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Text('Forgot Password?', style: TextStyle(
                      color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(height: 30),
                    buildVerifyEmail(),
                    SizedBox(height: 10),
                    buildSendBtn(),
                    SizedBox(height: 70),
                    buildVerifyOTP(),
                    SizedBox(height: 10),
                    buildValidOTPBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
      ),
      body: buildListBody(),
    );
  }
}


