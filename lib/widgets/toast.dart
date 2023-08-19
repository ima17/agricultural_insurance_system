import 'package:agricultural_insurance_system/configs/palette.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


ToastBottomSuccess(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(10, 0, 0, 0),
      textColor: Colors.black,
      fontSize: 16.0
  );
}

ToastBottomError(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Palette.kWarningBackground,
      textColor: Palette.kWarningColor,
      fontSize: 16.0
  );
}