import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/auth.dart';
import 'package:clonify/components/splash_screen.dart';

class UserAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionObject = Provider.of<SessionManagement>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("User admin"),
        ),
        body: Center(
            child: IconButton(
          icon: Icon(Icons.keyboard_return),
          iconSize: 150.0,
          onPressed: () async {
            var loggedOut = await sessionObject.logout();
            if (loggedOut) {
              print(Navigator.canPop(context));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  (Route<dynamic> route) => false);
            }
          },
        )));
  }
}
