import 'package:flutter/material.dart';

//闪屏
class LoadingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadingState();
  }
}

class LoadingState extends State<LoadingPage> {
  int secondsLeft = 1;

  @override
  void initState() {
    super.initState();
    _tick() {
      print(secondsLeft);
      if (secondsLeft == 0) {
        Navigator.of(context).pushReplacementNamed("app");
      } else {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            secondsLeft--;
          });
          _tick();
        });
      }
    }

    _tick();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: Stack(fit: StackFit.passthrough, children: <Widget>[
          Image.asset(
            'assets/images/bg_splash.jpg',
            fit: BoxFit.fill,
          ),
          Center(
              child: Text("崔世杰的企业站",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ))),
          Text('$secondsLeft s')
        ]));
  }
}
