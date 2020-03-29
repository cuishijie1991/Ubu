import 'package:flutter/material.dart';

//主页
class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsState();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toString
    return "新闻";
  }
}

class NewsState extends State<NewsPage> {
  int secondsLeft = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("新闻"),
      ),
    );
  }
}
