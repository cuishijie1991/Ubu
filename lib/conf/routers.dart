import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_website/features/horoscope/horoscope_detail_page.dart';
import 'package:flutter_website/features/horoscope/horoscope_page.dart';
import 'package:flutter_website/utils/utils.dart';

import '../app.dart';
import 'router_handler.dart';

class AppRouters {
  static TransitionType defaultTransitionType = TransitionType.inFromRight;
  static const String APP = '/app';
  static const String HOROSCOPE_PAGE = '/horoscope_page';
  static const String HOROSCOPE_DETAIL_PAGE = '/horoscope_detail_page';
  static const String BAZI_DETAIL_PAGE = '/bazi_detail_page';

  static void configureRoutes(Router router) {
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
          handler: baziDetailPageHandler,
          transitionType: defaultTransitionType);
  }
}
