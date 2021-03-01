import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class forgotpassword extends StatelessWidget {

    Widget buildforgotPassword(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Reset Password', style: TextStyle(
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
              keyboardType: TextInputType.emailAddress,
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
    Widget buildResetpassword(){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5,
          onPressed: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context) => forgotpassword()));
          },
          padding: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          color: Colors.pink,
          child: Text(
            'Confirm', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          ),
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x9900BBEE),
        leading: (
            new IconButton(icon: Icon(Icons.assignment_return), onPressed: (){
              Navigator.pop(context); // quay lai man hinh thu nhat bang Navigator.pop

            },)
        ),

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
                      vertical: 120
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Text('Reset Password', style: TextStyle(
                        color: Colors.pink, fontSize: 30, fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(height: 30),
                      Text('Enter your email address below to reset password', style: TextStyle(
                        color: Colors.black26, fontSize: 15
                      ),),
                      SizedBox(height: 30),
                      buildforgotPassword(),
                      SizedBox(height: 10),
                      buildResetpassword(),
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

