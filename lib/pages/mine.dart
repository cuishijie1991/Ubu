import 'package:flutter/material.dart';

//主页
class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  int secondsLeft = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("开发中，敬请期待..."),
      ),
    );
  }
}
