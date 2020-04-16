import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_website/conf/routers.dart';

class Application {
  static final Router router = Router();
  static final EventBus eventBus = EventBus();

  static void init() {
    AppRouters.configureRoutes(router);
  }
}
