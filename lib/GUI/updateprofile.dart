import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/Helper/api.services.dart';
import 'package:login_sigup_flutter/Model/user.dart';

class UpdateProfile extends StatelessWidget {

  final User user;

  UpdateProfile({@required this.user});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Widget _buildFullName(){
    return ListTile(
      title: Text("Full Name", style: TextStyle(
        color: Colors.red, fontSize: 16,
      ),),
      subtitle: TextFormField(
        keyboardType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: fullNameController,
        validator: (value){
          if(value.isEmpty){
            return "Full name can't be empty.";
          }else if(!RegExp("^[a-z A-Z]+").hasMatch(value)){
            return "Full name at least 2 words.";
          }
          return null;
        },
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
         //   hintText: user.fullName,
            icon: Icon(Icons.drive_file_rename_outline)
        ),
      ),
    );
  }
  Widget _buildEmail(){
    return ListTile(
      title: Text("Email Address", style: TextStyle(
        color: Colors.red, fontSize: 16,
      ),),
      subtitle: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: emailController,
        validator: (String value){
          if(value.isEmpty){
            return "Please enter email.";
          }
          if(!RegExp("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}").hasMatch(value)){
            return 'Enter a valid email address';
          }
          return null;
        },
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
          //  hintText: user.email,
            icon: Icon(Icons.email)
        ),
      ),
    );
  }
  Widget _buildPhoneNumber(){
    return ListTile(
      title: Text("Phone Number",style: TextStyle(
        color: Colors.red,fontSize: 16,
      ),),
      subtitle: TextFormField(
        keyboardType: TextInputType.phone,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: phoneController,
        validator: (value){
          if(value.isEmpty){
            return "Phone number can't be empty.";
          }
          if(!RegExp("^\\d{10}|^\\d{11}").hasMatch(value)){
            return 'Enter a valid phone number';
          }
          return null;
        },
        decoration: InputDecoration(
           // hintText: user.phoneNumber,
            enabledBorder: InputBorder.none,
            icon: Icon(Icons.phone)
        ),
      ),
    );
  }
  Widget _buildPassword(){
    return ListTile(
      title: Text("Password", style: TextStyle(
        color: Colors.red, fontSize: 16,
      ),),
      subtitle: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: passwordController,
        validator: (value){
          if(value.isEmpty){
            return "Password can't be empty.";
          }else if(!RegExp("^.*(?=.{8,})(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!*@#%^&+=]).*").hasMatch(value)){
            return "Password very bad, at least 8 characters.";
          }
          return null;
        },
        decoration: InputDecoration(
          icon: Icon(Icons.lock_clock),
          enabledBorder: InputBorder.none,
          //hintText: user.password,
        ),
      ),
    );
  }
  Widget buildAvatar(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      color: Colors.redAccent[200],
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://i.pinimg.com/originals/3d/1a/da/3d1ada2607633fd746c7f03f2c7a7bab.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("My Profile"),
          centerTitle: true,
          backgroundColor: Colors.redAccent[200],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                buildAvatar(),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildFullName(),
                      _buildEmail(),
                      _buildPhoneNumber(),
                      _buildPassword(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            APIService.updateProfileUser(user.id.toString(), user.username, passwordController.text, fullNameController.text, emailController.text, phoneController.text);
            _scaffoldKey.currentState.showSnackBar(snackBar);
          },
          icon: Icon(Icons.save),
          label: Text("Save"),
          backgroundColor: Colors.green,
        )
    );
  }

  final snackBar = SnackBar(content: Text("Update Successed.", style: TextStyle(
    fontSize: 16,),),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.green,
  );

}