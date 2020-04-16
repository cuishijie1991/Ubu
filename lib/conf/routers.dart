import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_website/features/horoscope/horoscope_detail_page.dart';
import 'package:flutter_website/features/horoscope/horoscope_page.dart';
import 'package:flutter_website/utils/utils.dart';

import '../app.dart';
import 'router_handler.dart';

class AppRouters {
  static const TransitionType defaultTransitionType =
      TransitionType.inFromRight;
  static const String APP = '/app';
  static const String WEBVIEW = '/webview';
  static const String LOGIN = '/login';
  static const String HOROSCOPE_PAGE = '/horoscope_page';
  static const String HOROSCOPE_DETAIL_PAGE = '/horoscope_detail_page';
  static const String BAZI_DETAIL_PAGE = '/bazi_detail_page';
  static Router _router;

  static void configureRoutes(Router router) {
    _router = router;
    router
      ..notFoundHandler = new Handler(
          type: HandlerType.function,
          handlerFunc:
              (BuildContext context, Map<String, List<String>> parameters) {
            Tool.toast('页面被外星人抓住了');
            return null;
          })
      ..define(HOROSCOPE_DETAIL_PAGE,
          handler: horoscopeDetailPageHandler,
          transitionType: defaultTransitionType)
      ..define(BAZI_DETAIL_PAGE,
          handler: baziDetailPageHandler, transitionType: defaultTransitionType)
      ..define(WEBVIEW,
          handler: webviewHandler, transitionType: defaultTransitionType)
      ..define(LOGIN, handler: loginHandler);
  }

  static Future<dynamic> navigateTo(BuildContext context, String path,
      {Map<String, dynamic> params,
      TransitionType transition: defaultTransitionType}) {
    if (params != null && params.isNotEmpty) {
      String query;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key].toString());
        if (query == null) {
          query = '?';
        } else {
          query += "\&";
        }
        query += "$key=$value";
      }
      path += query;
    }
    print(path);
    return _router.navigateTo(context, path, transition: transition);
  }
}
