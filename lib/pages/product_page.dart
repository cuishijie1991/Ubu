import 'package:flutter/material.dart';
import 'package:flutter_website/utils/NetService.dart';

//主页
class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductState();
  }
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toString
    return '产品';
  }
}

class ProductState extends State<ProductPage> {
  int secondsLeft = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("产品"),
      ),
    );
  }
}
