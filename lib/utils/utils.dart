import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tool {
  static Size _screenSize;

  static void toast(String msg) {
    if (msg == null || msg.length == 0) return;
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black26,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Size screenSize(BuildContext context) {
    if (_screenSize == null) _screenSize = MediaQuery.of(context).size;
    return _screenSize;
  }
}
