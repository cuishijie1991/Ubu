//全局配置
import 'package:flutter/material.dart';
import 'package:flutter_website/models/user.dart';

import '../app.dart';

class AppConfig {
  static const String APP_NAME = '优卜';
  static const String VERSION_NAME = '1.0.0';
  static const int VERSION_CODE = 100;
  static final ThemeData theme = ThemeData(primaryColor: Colors.redAccent);
  static UserInfo _user;

  static void login(UserInfo user) {
    AppConfig._user = user;
  }

  static void logOut() {
    AppConfig._user = null;
  }

  static UserInfo user() {
    return _user;
  }
}
