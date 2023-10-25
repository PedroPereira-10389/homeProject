import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

messageToast(text, status) {
  Color bg = Colors.green;

  switch (status) {
    case 500 || 400:
      bg = Colors.red;
      break;
    default:
      bg = Colors.orange;
  }

  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bg,
      textColor: Colors.white,
      fontSize: 16.0);
}
