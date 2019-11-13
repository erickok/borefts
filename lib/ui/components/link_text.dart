import 'package:borefts2020/ui/identity/color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  final String text;
  final String url;

  LinkText(this.text, this.url);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: redDark),
      ),
      onTap: () {
        launch(url);
      },
    );
  }
}