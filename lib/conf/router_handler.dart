import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_website/features/bazi/ba_zi_detail_page.dart';
import 'package:flutter_website/features/horoscope/horoscope_detail_page.dart';
import 'package:flutter_website/pages/user_login_page.dart';
import 'package:flutter_website/webview.dart';

var horoscopeDetailPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id']?.first;
  return HoroscopeDetailPage(id: id);
});

var baziDetailPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String name = params['name']?.first;
  String isMale = params['isMale']?.first;
  String isChineseCalendar = params['isChineseCalendar']?.first;
  String birthtime = params['birthtime']?.first;
  return BaZiDetailPage(
    name: name,
    isMale: isMale == 'true',
    birthtime: DateTime.fromMillisecondsSinceEpoch(int.parse(birthtime)),
    isChineseCalendar: isChineseCalendar == 'true',
  );
});

var webviewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String url = params['url']?.first;
  String title = params['title']?.first;
  return WebviewPage(
    url: url,
    title: title,
  );
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});
