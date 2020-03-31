import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/features/bazi/ba_zi_engine.dart';
import 'package:flutter_website/features/bazi/solar.dart';
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
    return BaZiDetailPageState();
  }
}

class BaZiDetailPageState extends State<BaZiDetailPage> {
  PaiPanEngine _engine;
  int _daYunIndex = 0;
  int _liuNianIndex = 0;
  static const double _leftTitleWidth = 28;
  static const double _yearDividerHeight = 20;
  TextStyle _ganStyle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87);
  TextStyle _ganSelectStyle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange);
  TextStyle _yearStyle =
      TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  void initState() {
    _engine = PaiPanEngine.loadBasic(
        widget.name, widget.birthtime, widget.isChineseCalendar, widget.isMale);
    super.initState();
  }

  BoxDecoration _redBackground() {
    return BoxDecoration(color: Colors.redAccent);
  }

  @override
  Widget build(BuildContext context) {
    int year = int.parse(_engine.daYunYear[_daYunIndex]);
    List<String> liuNiansLabels = _engine.getLiuNianStrings(year);
    List<String> liuNians = _engine.getLiuNian(year);
    var ganYear = liuNiansLabels[_liuNianIndex];
    List<String> liuYues = _engine.getLiuYueStrings(ganYear);
    return Scaffold(
      appBar: SimpleAppBar('八字排盘详情').build(context),
      body: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Row(children: [
                Container(
                  width: _leftTitleWidth,
                  decoration: _redBackground(),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '基\n本\n信\n息',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
                Expanded(
                  child: Text(
                    _engine.getBasicInfo(),
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                )
              ])),
              Container(
                height: 8,
                decoration: _redBackground(),
              ),
              Expanded(child: Row(children: getSiZhuItems(_engine.siZhuArray))),
              Container(
                  decoration: _redBackground(),
                  child: Center(
                      child: Row(
                    children: getDaYunYearItems(_engine.daYunYear),
                  ))),
              Expanded(
                  child: Row(children: getDaYunItems(_engine.daYunYearLabel))),
              Container(
                  decoration: _redBackground(),
                  child: Center(
                      child: Row(
                    children: getLiuNianYearItems(liuNians),
                  ))),
              Expanded(child: Row(children: getLiuNianItems(liuNiansLabels))),
              Container(
                  decoration: _redBackground(),
                  child: Center(
                      child: Row(
                    children: getLiuYueMonthItems(),
                  ))),
              Expanded(child: Row(children: getLiuYueItems(liuYues))),
            ],
          )),
    );
  }

  List<Widget> getSiZhuItems(List<String> siZhuList) {
    List<Widget> items = [
      Container(
          width: _leftTitleWidth,
          decoration: _redBackground(),
          child: Center(
            child: Text(
              '八\n字',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ))
    ];
    for (int i = 0; i < siZhuList.length; i++) {
      var item = Expanded(
        child: SizedBox(
            width: 20,
            child: Center(
                child: SizedBox(
                    width: 20,
                    child: Text(
                      siZhuList[i],
                      style: _ganSelectStyle,
                      textAlign: TextAlign.center,
                    )))),
      );
      items.add(item);
    }
    return items;
  }

  List<Widget> getDaYunYearItems(List<String> daYunYear) {
    List<Widget> items = [
      SizedBox(
        width: _leftTitleWidth,
        height: _yearDividerHeight,
      )
    ];
    for (int i = 0; i < daYunYear.length; i++) {
      var item = Expanded(
        child: Text(
          daYunYear[i],
          textAlign: TextAlign.center,
          style: _yearStyle,
        ),
      );
      items.add(item);
    }
    return items;
  }

  List<Widget> getDaYunItems(List<String> daYunYearLabel) {
    List<Widget> items = [
      Container(
          decoration: _redBackground(),
          width: _leftTitleWidth,
          child: Center(
            child: Text(
              '大\n运',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ))
    ];
    for (int i = 0; i < daYunYearLabel.length; i++) {
      var item = Expanded(
          child: GestureDetector(
        onTap: onDaYunTap(i),
        child: Center(
            child: SizedBox(
                width: 20,
                child: Text(
                  daYunYearLabel[i],
                  textAlign: TextAlign.center,
                  style: _daYunIndex == i ? _ganSelectStyle : _ganStyle,
                ))),
      ));
      items.add(item);
    }
    return items;
  }

  List<Widget> getLiuNianYearItems(List<String> liuNians) {
    List<Widget> items = [
      SizedBox(
        width: _leftTitleWidth,
        height: _yearDividerHeight,
      )
    ];
    for (int i = 0; i < liuNians.length; i++) {
      var item = Expanded(
        child: Text(
          liuNians[i],
          textAlign: TextAlign.center,
          style: _yearStyle,
        ),
      );
      items.add(item);
    }
    return items;
  }

  List<Widget> getLiuNianItems(List<String> liuNianLabels) {
    List<Widget> items = [
      Container(
        decoration: _redBackground(),
        width: _leftTitleWidth,
        child: Center(
            child: Text(
          '流\n年',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
      )
    ];
    for (int i = 0; i < liuNianLabels.length; i++) {
      var item = Expanded(
          child: GestureDetector(
              onTap: onLiuNinaTap(i),
              child: Center(
                child: SizedBox(
                    width: 20,
                    child: Text(
                      liuNianLabels[i],
                      textAlign: TextAlign.center,
                      style: _liuNianIndex == i ? _ganSelectStyle : _ganStyle,
                    )),
              )));
      items.add(item);
    }
    return items;
  }

  List<Widget> getLiuYueMonthItems() {
    List<Widget> items = [
      SizedBox(
        width: _leftTitleWidth,
        height: _yearDividerHeight,
      )
    ];
    for (int i = 0; i < Solar.lunarNumber.length; i++) {
      var item = Expanded(
        child: Text(
          Solar.lunarNumber[i],
          textAlign: TextAlign.center,
          style: _yearStyle,
        ),
      );
      items.add(item);
    }
    return items;
  }

  List<Widget> getLiuYueItems(List<String> liuYues) {
    List<Widget> items = [
      Container(
          decoration: _redBackground(),
          width: _leftTitleWidth,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '流\n月',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ))
    ];
    for (int i = 0; i < liuYues.length; i++) {
      var item = Expanded(
        child: Center(
            child: SizedBox(
                width: 20,
                child: Text(
                  liuYues[i],
                  textAlign: TextAlign.center,
                  style: _ganStyle,
                ))),
      );
      items.add(item);
    }
    return items;
  }

  Function onDaYunTap(int i) {
    return () {
      setState(() {
        _daYunIndex = i;
        _liuNianIndex = 0;
      });
    };
  }

  Function onLiuNinaTap(int i) {
    return () {
      setState(() => _liuNianIndex = i);
    };
  }
}
