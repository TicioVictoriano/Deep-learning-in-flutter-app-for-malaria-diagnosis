import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype/views/homeView.dart';

void main() => runApp(MyApp());

/*
  * TYPE: Main Class
  * NAME: MyApp
  * USAGE: It is used as the entry point for the application
  * */
class MyApp extends StatelessWidget {
  static const String _title = 'Malakiller';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: HomeView(title: _title),
    );
  }
}
