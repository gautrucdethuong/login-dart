import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY APP'),
      ),
      body: Center(
        child: Text('HELLO USER', style: TextStyle(
          fontSize: 20,
          backgroundColor: Colors.redAccent,
        ),),
      ),
      
    );
  }
}
