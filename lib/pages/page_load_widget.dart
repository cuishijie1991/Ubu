import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/conf/config.dart';

//加载loading页面
class PageLoadWidget extends StatefulWidget {
  final String noDataMsg;
  final String errorMsg;
  final String loadingMsg;
  final Function errorRetry;
  final LoadState state;
  final Widget child;

  PageLoadWidget(this.state,
      {@required this.child,
      this.loadingMsg: '加载中...',
      this.noDataMsg: '暂无数据！',
      this.errorMsg: '加载失败，点击重试！',
      this.errorRetry});

  @override
  State<StatefulWidget> createState() {
    return PageLoadWidgetState();
  }
}

class PageLoadWidgetState extends State<PageLoadWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        getWidgetByState(),
      ],
    );
  }

  Widget getWidgetByState() {
    switch (widget.state) {
      case LoadState.Loading:
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(AppConfig.theme.primaryColor),
                    strokeWidth: 2,
                  ),
                  height: 20,
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    widget.loadingMsg,
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
        );
      case LoadState.Error:
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
              child: OutlineButton(
            onPressed: () {
              if (widget.errorRetry != null) {
                widget.errorRetry();
              }
            },
            child: Text(
              widget.errorMsg,
              style: TextStyle(color: Colors.black54),
            ),
          )),
        );
      case LoadState.NoData:
        return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
                child: Text(
              widget.noDataMsg,
              style: TextStyle(color: Colors.black54),
            )));
      default:
        return Container();
    }
  }
}

//加载状态
enum LoadState { Loading, ShowContent, Error, NoData }
