import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  @override
  build(context) {
    return SafeArea(
      key: ValueKey<int>(3),
      child: ListView(
        children: <Widget>[
          InkWell(
              onDoubleTap: () => print('songs'),
              child: ListTile(
                title: Text('Songs'),
              )),
          InkWell(
              child: ListTile(
            title: Text('Artists'),
          )),
          InkResponse(
              child: ListTile(
            title: Text('Albums'),
          )),
        ],
      ),
    );
  }
}
