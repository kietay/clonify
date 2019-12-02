import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/auth_logic.dart';

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
          onPressed: () {
            sessionObject.logout();
          },
        ));
  }
}
