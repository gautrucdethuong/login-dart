import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class ErrorDialog {
   buildError(BuildContext context) {
    return errorDialog(context, "No internet connection. Connect to the internet and try again.", negativeText: "Try Again", negativeAction: (){
      waitDialog(context,duration: Duration(minutes: 3), message: "Please waiting...");
    },neutralText: "Okay", neutralAction: (){
    },icon: AlertDialogIcon.WIFI_OFF_ICON, title: "No network connection");
  }
}