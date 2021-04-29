import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_sigup_flutter/GUI/HomePage/Product/constants.dart';
import 'package:login_sigup_flutter/Model/product.dart';


class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.productName,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "\$${product.productPrice}",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 29),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    product.productImage,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
