import 'package:fluro/fluro.dart';
import 'package:flutter_website/conf/routers.dart';

class Application {
  static final Router router = Router();

  static void init() {
    AppRouters.configureRoutes(router);
  }
}
