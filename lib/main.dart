import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:inventariour/src/pages/home.dart';
import 'package:inventariour/src/pages/new-count.dart';

void main() {
  WidgetsFlutterBinding();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'nuevo': (BuildContext context) => NewCountPage(),
      },
    );
  }
}
