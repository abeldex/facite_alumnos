import 'package:facite_alumnos/auth/auth_page.dart';
import 'package:facite_alumnos/pages/HomePage.dart';
import 'package:facite_alumnos/pages/intro_screen.dart';
import 'package:facite_alumnos/pages/splash_screen.dart';
import 'package:flutter/material.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyApp(),
  "/intro": (BuildContext context) => IntroScreen(),
  "/login": (BuildContext context) => AuthPage(),
};

void main() => runApp(new MaterialApp(
    theme:
        ThemeData(primaryColor: Colors.blueGrey, accentColor: Colors.amber[200]),
    debugShowCheckedModeBanner: false,
    home: AuthPage(),
routes: routes));