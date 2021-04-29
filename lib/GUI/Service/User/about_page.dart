import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/constants.dart';


class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.network("https://i.imgur.com/fPl1WWa.png"),
                  ),
                ),
                flex: 5,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: <Widget>[
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text:
                              "\n\nThank you for your use. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                              style: CustomTextStyle.textFormFieldMedium
                                  .copyWith(fontSize: 15, color: Colors.grey),
                            )
                          ])),
                      SizedBox(
                        height: 24,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "More About",
                          style: CustomTextStyle.textFormFieldMedium
                              .copyWith(color: Colors.white),
                        ),
                        color: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(24))),
                      )
                    ],
                  ),
                ),
                flex: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}