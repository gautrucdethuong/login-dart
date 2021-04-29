import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/constants.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/home/home_screen.dart';
import 'package:login_sigup_flutter/Helper/CartService.dart';
import 'package:login_sigup_flutter/Helper/PaymentService.dart';
import 'package:login_sigup_flutter/Helper/UserService.dart';
import 'method_checkout_page.dart';


class CreditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreditPageState();
  }
}

class CreditPageState extends State<CreditPage> {
  final double delivery = 22.22;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool visible = false;

  Widget buildTotalPayment(){
    return FutureBuilder(
      future: APICart.TotalValueProduct(),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot){
        if(snapshot.hasData){
          double count = snapshot.data;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Transaction fee:"+"\n $delivery VND",
                style: CustomTextStyle.textFormFieldBold.copyWith(
                    fontSize: 14, color: Colors.black.withOpacity(0.9)),
              ),
              SizedBox(width: 120,),
              Text(
                "Total money:"+"\n ${count + delivery} VND",
                style: CustomTextStyle.textFormFieldBold
                    .copyWith(fontSize: 16, color: Colors.green),
              ),
            ],
          );
        }else{
          return Center(child: Text("LOADING..."),);
        }
        }
    );
  }
  Widget buildBtnPayment(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            primary: const Color(0xff1b447b),
          ),
          child: Container(
            margin: const EdgeInsets.all(8),
            child: const Text(
              'Payment',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'halter',
                fontSize: 14,
                package: 'flutter_credit_card',
              ),
            ),
          ),
          onPressed: () async {
            if (formKey.currentState.validate())  {
              // send sms otp user if input data validation
              await APIPayment.PaymentByCreditCard();
              // show dialog confirm code
              singleInputDialog(
                context,
                title: 'Verification Code',
                keyboardType: TextInputType.number,
                maxLines: 1,
                label: "OTP NUMBER",
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter OTP number.";
                  }
                  if (!RegExp("^\\d{6}").hasMatch(value)) {
                    return 'Enter a valid OTP number.';
                  }
                  return null;
                },
                positiveText: "Payment",
                positiveAction: (value) async {

                  final int id_user = await APIService.getIdUserLogin();
                  final String token = await APIService.getToken();

                  setState(() {
                    visible = false;
                  });

                  String body = jsonEncode(<String, String>{
                    'UserId' : id_user.toString(),
                    'otp' : value,
                  });
                  // call api verification
                  final response = await http.Client().post('http://10.0.2.2:5000/api/Cart/VerificationPayment/',
                    headers: <String, String>{
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $token',
                      'Accept': 'application/json',
                    },
                    body: body,
                  );
                  final repoData = json.decode(response.body);
                  final parsed = repoData['result'];

                  //check response api
                  if(response.statusCode == 200){
                    if( parsed == "Successed."){
                      successDialog(context, "",
                          title: "Payment Successful!",
                          neutralAction: (){
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => HomeScreen()));
                          }
                      );
                    }else{
                      setState(() {
                        visible = false;
                      });
                      warningDialog(context, "Code OTP incorrect.");
                    }
                  } else{
                    errorDialog(context, "Please check connection. Try again!!!");
                  }
                },
                neutralText: "Cancel",
              );
            } else {
              print('invalid!');
            }
          },
        ),
        SizedBox(
          width: 30,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            primary: const Color(0xff1b447b),
          ),
          child: Container(
            margin: const EdgeInsets.all(8),
            child: const Text(
              'Cancel ',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'halter',
                fontSize: 14,
                package: 'flutter_credit_card',
              ),
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (a, b, c) => CheckoutOnePage(),
                    transitionDuration: Duration(seconds: 2)));
          },
        )
      ],
    );
  }
  Widget buildCreditCard(){
    return CreditCardForm(
      formKey: formKey,
      obscureCvv: true,
      obscureNumber: true,
      cardNumber: cardNumber,
      cvvCode: cvvCode,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      themeColor: Colors.blue,
      cardNumberDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Number',
        hintText: 'XXXX XXXX XXXX XXXX',
      ),
      expiryDateDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Expired Date',
        hintText: 'XX/XX',
      ),
      cvvCodeDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'CVV',
        hintText: 'XXX',
      ),
      cardHolderDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Card Holder',
      ),
      onCreditCardModelChange: onCreditCardModelChange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName.toUpperCase(),
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    buildCreditCard(),
                    SizedBox(height: 15,),
                    buildTotalPayment(),
                    SizedBox(height: 30,),
                    buildBtnPayment(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
