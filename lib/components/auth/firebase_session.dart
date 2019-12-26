import 'package:flutter/material.dart';
import 'package:clonify/components/auth/auth_ui.dart';

class FirebaseSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 0, 254, 100),
              Color.fromRGBO(51, 51, 153, 100),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: AuthUI(),
        ));
  }
}
