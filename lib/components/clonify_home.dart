import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/auth_logic.dart';
import 'package:clonify/logic/home_logic.dart';
// this package is currently broken
// import 'package:firebase_storage_image/firebase_storage_image.dart';
import 'package:clonify/components/admin.dart';
import 'package:clonify/components/user.dart';
import 'package:clonify/components/recently_played.dart';

class ClonifyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionObject = Provider.of<SessionManagement>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Clonify"),
          backgroundColor: Colors.green.withOpacity(0.5),
          bottomOpacity: 1,
          textTheme: const TextTheme(
              title: TextStyle(fontFamily: 'ProximaNovaBold', fontSize: 30.0)),
          leading: GestureDetector(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.person),
              ),
            ),
            onTap: () {
              print("Person clicked");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiProvider(providers: [
                          ChangeNotifierProvider(
                            create: (_) => SessionManagement(),
                          ),
                        ], child: UserAdmin())),
              );
            },
          ),
          actions: [
            GestureDetector(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.settings),
                ),
              ),
              onTap: () {
                print("Settings clicked");
              },
            ),
          ]),
      bottomNavigationBar: Container(
        height: 60.0,
        color: Colors.grey.withOpacity(0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  print("You've been clicked");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.home),
                    Text("Home"),
                  ],
                )),
            GestureDetector(
                onTap: () {
                  print("You've been clicked");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search),
                    Text("Search"),
                  ],
                )),
            GestureDetector(
                onTap: () {
                  print("You've been clicked");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.library_music),
                    Text("Library"),
                  ],
                )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpotifyAdmin()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.lock),
                    Text("Admin"),
                  ],
                )),
          ],
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                  child: ChangeNotifierProvider(
                    create: (_) => RecentlyPlayedLogic(),
                    child: RecentlyPlayed(),
                  ),
                )
                // MadeforYou(),
                // RecomendedforYou(),
                // PopularTrending(),
                // EditorsPicks(),
                // GlobalReleases(),
                // BecauseYouLike(),
              ],
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("BUtton pressed bldu"),
        tooltip: 'Increment Counter',
        child: Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
