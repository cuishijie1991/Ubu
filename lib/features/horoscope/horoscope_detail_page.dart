//星座详情页面
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_website/features/horoscope/config.dart';
import 'package:flutter_website/features/horoscope/models/horoscope.dart';
import 'package:flutter_website/features/horoscope/http_service.dart';
import 'package:flutter_website/features/horoscope/models/fortune.dart';
import 'package:flutter_website/pages/page_load_widget.dart';
import 'package:flutter_website/pages/simple_appbar.dart';
import 'package:flutter_website/utils/utils.dart';

//星座运势详情
class HoroscopeDetailPage extends StatefulWidget {
  final String id;

  HoroscopeDetailPage({Key key, @required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HoroscopeDetailPageState();
  }
}

class HoroscopeDetailPageState extends State<HoroscopeDetailPage> {
  Horoscope _h;
  Fortune _fortune;
  LoadState _loadState = LoadState.Loading;

  @override
  void initState() {
    if (widget.id == null) return;
    int _id = int.parse(widget.id);
    for (var h in HoroscopeConfig.horoscopes) {
      if (h.astroid == _id) {
        _h = h;
        break;
      }
    }
    if (_h == null) {
      Tool.toast('param! error');
      Navigator.of(context).pop(null);
    } else {
      _fetchFromServer();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children
      ..addAll(_buildTodayPart() ?? [])
      ..addAll(_buildWeekPart() ?? [])
      ..addAll(_buildYearPart() ?? []);

    return Scaffold(
      appBar: SimpleAppBar('${_h.astroname} (${_h.date})').build(context),
      body: PageLoadWidget(_loadState,
          child: _fortune == null
              ? Container()
              : ListView(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  children: children,
                ),
          errorRetry: _fetchFromServer),
    );
  }

  _fetchFromServer() {
    HoroscopeHttpService.getFortune(_h.astroid, DateTime.now(), (data) {
      if (!mounted) return;
      setState(() {
        this._fortune = data;
        _loadState = LoadState.ShowContent;
      });
    }, (int code, dynamic e) {
      if (!mounted) return;
      setState(() {
        _loadState = LoadState.Error;
      });
      Tool.toast(e.toString());
    });
  }

  //title文本样式
  TextStyle titleStyle = TextStyle(
      color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 18);

  //subtitle文本样式
  TextStyle subtitleStyle = TextStyle(
      color: Colors.lightBlue, fontWeight: FontWeight.normal, fontSize: 14);

  //今日运势
  List<Widget> _buildTodayPart() {
    //评星样式
    Widget _buildRatingBar(double size, String rateValue) {
      return RatingBar(
        itemSize: size,
        initialRating: double.parse(rateValue),
        itemBuilder: (ctx, index) {
          return Icon(Icons.star, color: Colors.orange);
        },
      );
    }

    return [
      SizedBox(height: 20),
      Text('今日运势', style: titleStyle),
      SizedBox(height: 10),
      Row(
        children: <Widget>[
          Image.network(_h.pic),
          SizedBox(width: 30),
          _buildRatingBar(38, _fortune.today['summary'] ?? ''),
        ],
      ),
      SizedBox(height: 10),
      Row(children: <Widget>[
        Expanded(
            flex: 1,
            child: Text.rich(TextSpan(
                text: '爱情运势 ',
                style: TextStyle(color: Colors.black54),
                children: [
                  WidgetSpan(
                      child: _buildRatingBar(18, _fortune.today['love'] ?? ''))
                ]))),
        Expanded(
            flex: 1,
            child: Text.rich(TextSpan(
                text: '事业学业 ',
                style: TextStyle(color: Colors.black54),
                children: [
                  WidgetSpan(
                      child:
                          _buildRatingBar(18, _fortune.today['career'] ?? ''))
                ])))
      ]),
      SizedBox(height: 10),
      Row(children: <Widget>[
        Expanded(
            flex: 1,
            child: Text.rich(TextSpan(
                text: '财富运势 ',
                style: TextStyle(color: Colors.black54),
                children: [
                  WidgetSpan(
                      child: _buildRatingBar(18, _fortune.today['money'] ?? ''))
                ]))),
        Expanded(
            flex: 1,
            child: Text.rich(TextSpan(
                text: '健康指数 ',
                style: TextStyle(color: Colors.black54),
                children: [
                  WidgetSpan(
                      child:
                          _buildRatingBar(18, _fortune.today['health'] ?? ''))
                ])))
      ]),
      SizedBox(height: 10),
      Row(children: <Widget>[
        Expanded(
            flex: 1,
            child: Text.rich(TextSpan(
                text: '幸运数字 ',
                style: TextStyle(color: Colors.black54),
                children: [
                  TextSpan(
                      text: _fortune.today['number'] ?? '',
                      style: TextStyle(color: Colors.black87)),
                ]))),
        Expanded(
            flex: 1,
            child: Text.rich(TextSpan(
                text: '幸运颜色 ',
                style: TextStyle(color: Colors.black54),
                children: [
                  TextSpan(
                    text: _fortune.today['color'] ?? '',
                    style: TextStyle(color: Colors.black87),
                  )
                ]))),
      ]),
      SizedBox(height: 10),
      Text(
        (_fortune.today['presummary'] ?? '' as String)
            .replaceAll(RegExp('。'), '。\n'),
        strutStyle: StrutStyle(leading: .5),
      ),
      Divider(height: 1, color: Colors.black12)
    ];
  }

  //本周运势
  List<Widget> _buildWeekPart() {
    return [
      SizedBox(height: 20),
      Text('本周运势', style: titleStyle),
      SizedBox(height: 20),
      Text('爱情运势', style: subtitleStyle),
      SizedBox(height: 7),
      Text(_fortune.week['love'] ?? ''),
      SizedBox(height: 7),
      Text('事业学业', style: subtitleStyle),
      SizedBox(height: 7),
      Text(_fortune.week['career'] ?? ''),
      SizedBox(height: 7),
      Text('财运', style: subtitleStyle),
      SizedBox(height: 7),
      Text(_fortune.week['money'] ?? ''),
      SizedBox(height: 7),
      Text('健康', style: subtitleStyle),
      SizedBox(height: 7),
      Text(_fortune.week['health'] ?? ''),
      SizedBox(height: 7),
      Text(_fortune.week['job'] ?? ''),
      SizedBox(height: 10),
      Divider(height: 1, color: Colors.black12)
    ];
  }

  //本年运势
  List<Widget> _buildYearPart() {
    return [
      SizedBox(height: 20),
      Text('今年运势', style: titleStyle),
      SizedBox(height: 20),
      Text('运势总结', style: subtitleStyle),
      SizedBox(height: 7),
      Text(_fortune.year['summary'] ?? ''),
      SizedBox(height: 7),
      Text('爱情运势', style: subtitleStyle),
      SizedBox(height: 7),
      Text(_fortune.year['love'] ?? ''),
      SizedBox(height: 7),
      Text('事业学业', style: subtitleStyle),
      SizedBox(height: 7),
      Text(_fortune.year['career'] ?? ''),
      SizedBox(height: 7),
      Text('财运', style: subtitleStyle),
      SizedBox(height: 7),
      Text(_fortune.year['money'] ?? ''),
      SizedBox(height: 20),
    ];
  }
}
