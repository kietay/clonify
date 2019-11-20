import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class RecentlyPlayedItem {
  String id;
  String type;
  DateTime lastPlayed;
  String thumbnailUrl;
  String title;

  RecentlyPlayedItem(
      {this.id, this.type, this.lastPlayed, this.thumbnailUrl, this.title});
}

class RecentlyPlayedLogic extends ChangeNotifier {
  bool funCalled = false;

  List<RecentlyPlayedItem> recentlyPlayed = [];

  void getSongHistory() async {
    // Query the db for the user's songs ids then fetch details of all those songs
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    print("Getting song history for user");
    QuerySnapshot qsnap = await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .collection("songHistory")
        .getDocuments();

    final fetchedSongs = await Future.wait(qsnap.documents.map((elem) =>
        Firestore.instance.collection("songs").document(elem['songId']).get()));

    recentlyPlayed = fetchedSongs.map((fdoc) => RecentlyPlayedItem(
        id: fdoc.data['songId'],
        lastPlayed: fdoc.data['lastPlayed'],
        thumbnailUrl: fdoc.data['thumbnailUrl'],
        type: 'song',
        title: fdoc.data['songTitle']));

    getPlaylistHistory();
  }

  void getPlaylistHistory() async {
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qsnap = await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .collection("playlistHistory")
        .getDocuments();

    List<DocumentSnapshot> data = qsnap.documents;

    for (int i = 0; i < data.length; i++) {
      await Firestore.instance
          .collection("users")
          .document(data[i]['playlistUserId'])
          .collection("userCreatedPlayLists")
          .document(data[i]['playListId'])
          .get()
          .then((documentSnapshot) {
        recentlyPlayed.add(RecentlyPlayedItem(
            id: data[i]['playListId'],
            thumbnailUrl: './images/spotify_smaller.png',
            lastPlayed: data[i]['lastPlayed'],
            type: 'playlist',
            title: documentSnapshot['playlistName']));
      });
    }

    // var recents = data.map((playlist) => {

    funCalled = true;
    notifyListeners();
  }
}
