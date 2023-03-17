import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sir/res/colours.dart';


class Utils {
  static void fieldFocus(
      BuildContext context, FocusNode currentNode, FocusNode nextFocus) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        backgroundColor: AppColors.primaryTextTextColor,
        msg: message,
        textColor: AppColors.whiteColor,
        fontSize: 16);
  }
}
