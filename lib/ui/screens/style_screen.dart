import 'package:borefts2020/data/models/styles.dart';
import 'package:flutter/material.dart';

class StyleScreen extends StatelessWidget {
  final Style style;

  StyleScreen(this.style);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(style.name),
      ),
      body: Center(
        child: Text(style.name),
      ),
    );
  }
}
