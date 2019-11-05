import 'package:borefts2020/ui/identity/color.dart';
import 'package:borefts2020/ui/identity/theme.dart';
import 'package:borefts2020/ui/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: redVeryDark));

    return MaterialApp(
      title: 'Borefts 2020',
      theme: boreftsLightTheme(),
      home: TabsScreen(),
    );
  }
}