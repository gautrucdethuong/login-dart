import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/CartPage/page/wallet_page_checkout.dart';
import 'cart_page_shopping.dart';
import 'credit_cart_page.dart';

class CheckoutOnePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(icon: Icon(Icons.keyboard_backspace),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CartShopPage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            const SizedBox(height: 30.0),
            Text(
              "Select a payment method",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Card (
              elevation: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon (
                        Icons.delivery_dining,
                        color: Colors.cyan,
                        size: 45
                    ),
                    title: Text(
                      "Pay on delivery",
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('You can pay on delivery with POS or Cash'),
                    onTap: () async {
                      return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ConfirmOrderPage()));
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10.0),
            Card (
              elevation: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon (
                        Icons.wallet_giftcard,
                        color: Colors.cyan,
                        size: 45
                    ),
                    title: Text(
                      "Pay with wallet",
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('Wallet Balance: \$ 10.00'),
                    onTap: (){},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10.0),
            Card (
              elevation: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon (
                        Icons.credit_card_outlined,
                        color: Colors.cyan,
                        size: 45
                    ),
                    title: Text(
                      "Pay with your card",
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('Your security is our priority. Enjoy easy and pick payment'),
                    onTap: (){
                      return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreditPage()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}