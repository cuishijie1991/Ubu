import 'package:flutter/material.dart';

class SimpleAppBar {
  final String title;
  final bool showBack;
  final Function onBack;

  SimpleAppBar(this.title, {this.showBack: true, this.onBack, this.endButtons});

  final List<Widget> endButtons;

  AppBar build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            if (showBack) {
              if (onBack != null) {
                onBack();
              } else {
                Navigator.pop(context);
              }
            }
          },
          child: showBack ? Icon(Icons.arrow_back_ios) : null,
        ),
        actions: endButtons);
  }
}
