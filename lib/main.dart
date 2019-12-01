import 'package:flutter/material.dart';
import 'package:clonify/components/auth.dart';

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
