import 'package:flutter/material.dart';
import 'package:lifeai/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: Color(0xff7289da)),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
