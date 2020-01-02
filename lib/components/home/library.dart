import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  @override
  build(context) {
    return SafeArea(
      key: ValueKey<int>(3),
      child: ListView(
        children: <Widget>[Text('Hello ur now libary')],
      ),
    );
  }
}
