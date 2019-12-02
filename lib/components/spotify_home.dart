import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/auth_logic.dart';
import 'package:clonify/logic/home_logic.dart';
import 'package:firebase_storage_image/firebase_storage_image.dart';
import 'package:clonify/components/admin.dart';

class SpotifyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionObject = Provider.of<SessionManagement>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Clonify"),
          backgroundColor: Colors.green.withOpacity(0.5),
          bottomOpacity: 1,
          textTheme: const TextTheme(
              title:
                  TextStyle(fontFamily: 'Proxima Nova Bold', fontSize: 30.0)),
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
                MaterialPageRoute(builder: (context) => SpotifyAdmin()),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text("Search"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.library_music),
                Text("Library"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.lock),
                Text("Admin"),
              ],
            ),
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
                    builder: (_) => RecentlyPlayedLogic(),
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

class RecentlyPlayed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recentlyPlayed = Provider.of<RecentlyPlayedLogic>(context);
    if (!recentlyPlayed.historyFetched) {
      recentlyPlayed.fetchUserHistory();
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 10.0),
            child: Text(
              "Recently played",
              style: TextStyle(fontFamily: 'Proxima Nova Bold', fontSize: 30.0),
            ),
          ),
          !recentlyPlayed.historyFetched
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: recentlyPlayed.recentlyPlayed.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: MediaQuery.of(context).size.height * 0.18,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: recentlyPlayed.recentlyPlayed[i].type ==
                                        "song"
                                    ? FirebaseStorageImage(recentlyPlayed
                                        .recentlyPlayed[i].thumbnailUrl)
                                    : AssetImage(recentlyPlayed
                                        .recentlyPlayed[i].thumbnailUrl),
                                fit: BoxFit.cover,
                              )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              recentlyPlayed.recentlyPlayed[i].title,
                              style: TextStyle(
                                fontFamily: 'Proxima Nova Bold',
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
