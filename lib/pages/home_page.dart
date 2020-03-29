import 'package:flutter/material.dart';
import 'package:flutter_website/models/product.dart';
import 'package:flutter_website/pages/home_banner.dart';
import 'package:flutter_website/utils/NetService.dart';
import 'package:flutter_website/utils/utils.dart';

import 'home_banner.dart';

//主页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toString
    return "主页";
  }
}

class HomePageState extends State<HomePage> {
  int pageIndex = 0;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
//    NetService.getInstance().getProducts(pageIndex, (error) {
//      Tool.toast(error.e.toString());
//    });

//        .then((list) {
//      if (list == null) {
//        Tool.toast("no data");
//      } else {
//        setState(() {
//          _products.addAll(list);
//        });
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HomeBannerWidget(),
        Text('产品列表'),
        RaisedButton(
          child: Text('request'),
          onPressed: () {
            Tool.toast('request');
            NetService.getInstance().getProducts(pageIndex, (list) {
              setState(() {
                _products.addAll(list);
              });
            }, null);
          },
        ),
        Expanded(
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Product product = _products[index];
                  return Text(product.desc);
                },
                itemCount: _products.length,
                itemExtent: 50.0)),
      ],
    );
  }
}
