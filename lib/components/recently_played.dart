import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/homedart';
import 'package:firebase_storage/firebase_storage.dart';

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
              style: TextStyle(fontFamily: 'ProximaNovaBold', fontSize: 30.0),
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
                    itemBuilder: (context, song) {
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
                                image:
                                    recentlyPlayed.recentlyPlayed[song].type ==
                                            'song'
                                        ? NetworkImage(recentlyPlayed
                                            .recentlyPlayed[song].thumbnailUrl)
                                        : AssetImage(recentlyPlayed
                                            .recentlyPlayed[song].thumbnailUrl),
                                fit: BoxFit.cover,
                              )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              recentlyPlayed.recentlyPlayed[song].title,
                              style: TextStyle(
                                fontFamily: 'ProximaNovaBold',
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
