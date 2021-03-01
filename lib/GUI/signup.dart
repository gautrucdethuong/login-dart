import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_sigup_flutter/Helper/api.services.dart';
import 'package:login_sigup_flutter/Model/user.dart';

class signup extends StatefulWidget {
  final User user;
  signup(this.user);

  @override
  _signupState createState() => _signupState(user);
}

class _signupState extends State<signup> {
  User user;
  _signupState(this.user);

  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

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
          child: TextField(
            //keyboardType: TextInputType.emailAddress,
            controller: emailController,
            onChanged:(value) => updateEmail(),
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
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => updateUsername(),
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
          child: TextField(
            obscureText: true,
            onChanged: (value) => updatePassword(),
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
          child: TextField(
            obscureText: true,
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
          child: TextField(
            keyboardType: TextInputType.name,
            onChanged:(value) => updateFullname(),
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
  Widget buildSignUpBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: (){
          btnRegister();
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
      ),
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
          child: TextField(
            keyboardType: TextInputType.name,
            onChanged: (value) => updatePhone(),
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
  void btnRegister() async{
    //var saveRepose = await APIService.PostUser(user);
   // saveRepose == true ? Navigator.pop(context,true) : null;
  }

  void updateFullname(){
    //user.fullname = fullnameController.text;
  }
  void updateUsername(){
    user.username = usernameController.text;
  }
  void updateEmail(){
    user.email = emailController.text;
  }
  void updatePhone(){
    //user.numberphone = phoneController.text;
  }
  void updatePassword(){
    //user.password = passwordController.text;
  }

  @override
  Widget build(BuildContext context) {

    //fullnameController.text = user.fullname;
    emailController.text = user.email;
    usernameController.text = user.username;
    //phoneController.text = user.numberphone;
    passwordController.text = user.password;

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
