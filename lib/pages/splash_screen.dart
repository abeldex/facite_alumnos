import 'dart:async';
import 'package:flutter/material.dart';
import 'package:facite_alumnos/utils/my_navigator.dart';
import 'package:facite_alumnos/globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if(globals.cuenta != null){
      MyNavigator.goToHome(context);
    }
    else{
      Timer(Duration(seconds: 3), () => MyNavigator.goToLogin(context));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: DecorationImage(image: new AssetImage("assets/img/bg.png"), fit: BoxFit.cover),
              color: Colors.blueGrey),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/img/logo_facite.png", width: 200.00,),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "FACITE ALUMNOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}