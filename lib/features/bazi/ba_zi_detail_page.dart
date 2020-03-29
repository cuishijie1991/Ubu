import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/pages/simple_appbar.dart';

class BaZiDetailPage extends StatefulWidget {
  final String name;
  final DateTime birthtime;
  final bool isMale;
  final bool isChineseCalendar;

  const BaZiDetailPage(
      {Key key, this.name, this.birthtime, this.isMale, this.isChineseCalendar})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print('$name $isMale');
    return BaZiDetailPageState();
  }
}

class BaZiDetailPageState extends State<BaZiDetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SimpleAppBar('八字排盘详情').build(context),
      body: Container(
        child: Text('八字排盘详情'),
      ),
    );
  }
}
