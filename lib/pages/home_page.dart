import 'package:flutter/material.dart';
import 'package:flutter_website/conf/application.dart';
import 'package:flutter_website/conf/home_config.dart';
import 'package:flutter_website/conf/routers.dart';
import 'package:flutter_website/events/app_tab_change_event.dart';
import 'package:flutter_website/models/home/Article.dart';
import 'package:flutter_website/models/home/Listmenu.dart';
import 'package:flutter_website/models/home/home_model.dart';
import 'package:flutter_website/pages/home_banner.dart';
import 'package:flutter_website/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_banner.dart';

//主页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  HomeModel _homeModel;

  @override
  void initState() {
    _homeModel = HomeModel.fromJson(home);
    super.initState();
  }

  _fetchConfig() {
    Future.delayed(Duration(seconds: 1), () {
      _refreshController.refreshCompleted();
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        header: WaterDropHeader(
            complete: Text('数据已是最新', style: TextStyle(color: Colors.grey))),
        controller: _refreshController,
        onRefresh: _fetchConfig,
        enablePullDown: true,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            HomeBannerWidget(_homeModel.data.index.banner),
            SizedBox(
              height: 20,
            ),
            GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _homeModel.data.index.listmenu.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  Listmenu m = _homeModel.data.index.listmenu[index];
                  return GestureDetector(
                      onTap: () {
                        if (index < 4) {
                          Application.eventBus
                              .fire(HomeBottomTabChangeEvent('BaZi'));
                        } else {
                          Tool.toast('暂未开放');
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            m.icon,
                            width: 38,
                            height: 38,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(m.title)
                        ],
                      ));
                }),
            Container(
              height: 9,
              color: Color(0x0F000000),
            ),
            ListView.separated(
                separatorBuilder: (context, index) {
                  return Container(
                    height: 0.3,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    color: Colors.black12,
                  );
                },
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _homeModel.data.article.length,
                itemBuilder: (context, index) {
                  Article a = _homeModel.data.article[index];
                  return Container(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                          onTap: () {
                            AppRouters.navigateTo(context, AppRouters.WEBVIEW,
                                params: {'url': a.url, 'title': a.title});
                          },
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        a.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        a.content,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(a.titleimage)))
                            ],
                          )));
                }),
          ],
        ));
  }
}
