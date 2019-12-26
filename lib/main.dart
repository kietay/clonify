import 'package:flutter/material.dart';
import 'package:clonify/components/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Clonify',
    theme: ThemeData(
        fontFamily: 'Proxima Nova',
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600]),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
