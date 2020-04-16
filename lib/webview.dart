import 'package:flutter/material.dart';
import 'package:flutter_website/pages/simple_appbar.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// ignore: must_be_immutable
class WebviewPage extends StatefulWidget {
  final String url;
  String title = '';

  WebviewPage({Key key, this.url, title}) : super(key: key) {
    if (title != null) {
      this.title = title;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return WebviewPageState();
  }
}

class WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: SimpleAppBar(widget.title).build(context),
      url: widget.url,
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      withJavascript: true,
      appCacheEnabled: true,
    );
  }
}
