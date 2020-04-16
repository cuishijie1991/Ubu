import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/conf/application.dart';
import 'package:flutter_website/conf/routers.dart';
import 'package:flutter_website/features/horoscope/config.dart';
import 'package:flutter_website/features/horoscope/models/horoscope.dart';

class HoroscopePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HoroscopePageState();
  }
}

class HoroscopePageState extends State<HoroscopePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView.builder(
              itemCount: HoroscopeConfig.horoscopes.length,
              padding: EdgeInsets.only(
                  left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                Horoscope h = HoroscopeConfig.horoscopes[index];
                return HItemWidget(h);
              }),
        )
      ],
    );
  }
}

class HItemWidget extends StatelessWidget {
  final Horoscope h;

  HItemWidget(this.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: () {
            Application.router.navigateTo(
                context, '${AppRouters.HOROSCOPE_DETAIL_PAGE}?id=${h.astroid}');
          },
          child: Column(children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.network(
                  h.pic,
                  width: 60,
                  height: 60,
                  fit: BoxFit.fill,
                )),
            Padding(
              child: Text(
                h.astroname,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.only(top: 5, bottom: 1),
            ),
            Text(h.date),
          ])),
    );
  }
}
