import 'package:flutter/material.dart';
import 'package:flutter_website/features/bazi/ba_zi_page.dart';
import 'package:flutter_website/features/horoscope/horoscope_page.dart';
import 'package:flutter_website/pages/mine.dart';

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
    NavigationConfig('八字', Icons.exposure, BaZiPage()),
    NavigationConfig('星座', Icons.grid_on, HoroscopePage()),
    NavigationConfig('我的', Icons.people, MinePage()),
  ];
  int curNavIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConfig.APP_NAME,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
//        leading: Icon(Icons.home),
//        actions: <Widget>[
//          Padding(
//            padding: EdgeInsets.only(right: 20),
//            child: GestureDetector(
//              onTap: () {},
//              child: Icon(Icons.search),
//            ),
//          )
//        ],
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
    );
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
