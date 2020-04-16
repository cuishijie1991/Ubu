import 'package:flutter/material.dart';
import 'package:flutter_website/app.dart';
import 'package:flutter_website/conf/application.dart';
import 'conf/config.dart';

void main() {
  Application.init();
  var app = MaterialApp(
    onGenerateRoute: Application.router.generator,
    debugShowCheckedModeBanner: false,
    title: AppConfig.APP_NAME,
    theme: AppConfig.theme,
    home: AppPage(),
  );
  runApp(app);
}
