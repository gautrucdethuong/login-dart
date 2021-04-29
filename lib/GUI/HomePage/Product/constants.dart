import 'package:flutter/material.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 10.0;


//const kDefaultPaddingFooter = 10.0;
class CustomColors {
  static var COLOR_FB = Color(0xFF3b5998);
  static var COLOR_GREEN = Color(0xFF01a550);
  static var EDIT_PROFILE_PIC_FIRST_GRADIENT = Color(0xFF6713D2);
  static var EDIT_PROFILE_PIC_SECOND_GRADIENT = Color(0xFFCC208E);
}

class Utils {
  static getSizedBox({double width, double height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}

class CustomTextStyle {
  static var textFormFieldRegular = TextStyle(
      fontSize: 16,
      fontFamily: "Helvetica",
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static var textFormFieldLight =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w200);

  static var textFormFieldMedium =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w500);

  static var textFormFieldSemiBold =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w600);

  static var textFormFieldBold =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w700);

  static var textFormFieldBlack =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w900);
}

const Color success = Color(0xff44c93a);
const Color danger = Color(0xffff4657);
const Color info = Color(0xff5bc0de);
const Color warning = Color(0xfffeba06);

const Color bgAppbarBlack = Color(0xff232528);
const Color bgAppbarWhite = Color(0xffffffff);

const Color bgAppbarGradientStart = Color(0xFF191C20);
const Color bgAppbarGradientEnd = Color(0xFF29313E);

const Color bgButtonBlack = Color(0xFF17181A);
const Color bgButtonBlue = Color(0xFF3B66BE);
const Color bgButtonWhite = Color(0xffffffff);

const Color black = Color(0xff000000);
const Color white = Color(0xffffffff);
const Color blue = Color(0xff0D47A1);
const Color grey = Color(0xffbdbdbd);
const Color lineWhite = Color(0xffececec);
const Color lineGrey = Color(0xffbdbdbd);
const Color lineTextGrey = Color(0xff9E9E9E);

const Color darkModeButton = Color(0xff2F3641);
const Color lightModeButton = Color(0xff000000);
const Color darkBgCircle = Color(0xff2F3641);

