import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_website/conf/application.dart';
import 'package:flutter_website/events/app_tab_change_event.dart';
import 'package:flutter_website/features/bazi/ba_zi_page.dart';
import 'package:flutter_website/features/horoscope/horoscope_page.dart';
import 'package:flutter_website/pages/home_page.dart';
import 'package:flutter_website/pages/mine_page.dart';
import 'package:flutter_website/utils/utils.dart';
import 'conf/config.dart';

//主页
class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppPageState();
  }
}

class AppPageState extends State<AppPage> {
  List<NavigationConfig> navConfigs = [
    NavigationConfig('首页', Icons.home, HomePage()),
    NavigationConfig('八字', Icons.exposure, BaZiPage()),
    NavigationConfig('星座', Icons.grid_on, HoroscopePage()),
    NavigationConfig('我的', Icons.people, MinePage()),
  ];
  int curNavIndex = 0;

  DateTime lastPopTime;
  StreamSubscription _homeBottomTabChangeEventListener;

  @override
  void initState() {
    _homeBottomTabChangeEventListener =
        Application.eventBus.on<HomeBottomTabChangeEvent>().listen((e) {
      print('listener $e');
      if (mounted) {
        switch (e.target) {
          case 'BaZi':
            for (NavigationConfig nav in navConfigs) {
              if (nav.content is BaZiPage) {
                setState(() {
                  curNavIndex = navConfigs.indexOf(nav);
                });
                break;
              }
            }
            break;
          default:
            print('${e.target} not found');
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _homeBottomTabChangeEventListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          bool willPop;
          if (lastPopTime == null ||
              DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            Tool.toast('再按一次退出');
            willPop = false;
          } else {
            lastPopTime = DateTime.now();
            willPop = true;
          }
          return Future.value(willPop);
        },
        child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.color),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  AppConfig.APP_NAME,
                  textAlign: TextAlign.center,
                ),
                centerTitle: true,
              ),
              bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: true,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.redAccent,
                items: _getBottomNavigationBarItems(),
                onTap: (index) {
                  setState(() {
                    curNavIndex = index;
                  });
                },
                currentIndex: curNavIndex,
                type: BottomNavigationBarType.fixed,
              ),
              body: navConfigs[curNavIndex].content,
            )));
  }

  List<BottomNavigationBarItem> _getBottomNavigationBarItems() {
    List<BottomNavigationBarItem> items = [];
    navConfigs.forEach((config) {
      items.add(BottomNavigationBarItem(
          icon: Icon(config.icon), title: Text(config.title)));
    });
    return items;
  }
}

class NavigationConfig {
  String title;
  IconData icon;
  Widget content;

  NavigationConfig(this.title, this.icon, this.content);
}
