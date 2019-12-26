import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/auth.dart';

class UserAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionObject = Provider.of<SessionManagement>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("User admin"),
        ),
        body: IconButton(
          icon: Icon(Icons.gavel),
          onPressed: () async {
            var loggedOut = await sessionObject.logout();
            if (loggedOut) {
              print(Navigator.canPop(context));
            }
          },
        ));
    // todo pull back to login screen
  }
}
