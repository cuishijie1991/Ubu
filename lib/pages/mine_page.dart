import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/conf/config.dart';
import 'package:flutter_website/models/user.dart';
import 'package:flutter_website/utils/utils.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  UserInfo user;

  @override
  Widget build(BuildContext context) {
    user = AppConfig.user();
    double width = MediaQuery.of(context).size.width;
    double bannerHeight = width * 300 / 720;
    return ListView(
      children: <Widget>[
        Image.asset(
          'assets/images/mine_banner.jpeg',
          fit: BoxFit.cover,
          height: bannerHeight,
        ),
        SizedBox(
          height: 200,
        ),
        Container(
            padding: EdgeInsets.only(left: 38, right: 38),
            child: FlatButton(
              color: AppConfig.theme.primaryColor,
              highlightColor: AppConfig.theme.primaryColor,
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text(user == null ? '注册 / 登录' : '退出'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0)),
              onPressed: () {
                if (user == null) {
                  Future.delayed(Duration(seconds: 2), () {
                    Tool.toast('服务器繁忙，请稍后再试！');
                  });

//                  AppRouters.navigateTo(context, AppRouters.LOGIN).then((v) {
//                    if (v != null) {
//                      setState(() {
//                        user = AppConfig.user();
//                      });
//                    }
//                  });
                }
              },
            )),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            'V ${AppConfig.VERSION_NAME}',
            style: TextStyle(color: Colors.black38),
          ),
        )
      ],
    );
  }
}
