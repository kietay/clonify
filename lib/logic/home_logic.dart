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
  bool historyFetched = false;

  List<RecentlyPlayedItem> recentlyPlayed = [];

  void fetchUserHistory() async {
    recentlyPlayed += await getSongHistory();
    recentlyPlayed += await getPlaylistHistory();
    historyFetched = true;
    notifyListeners();
  }

  Future<List<RecentlyPlayedItem>> getSongHistory() async {
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

    return fetchedSongs
        .map((fdoc) => RecentlyPlayedItem(
            id: fdoc.data['songId'],
            lastPlayed: fdoc.data['lastPlayed'],
            thumbnailUrl: fdoc.data['thumbnailUrl'],
            type: 'song',
            title: fdoc.data['songTitle']))
        .toList();
  }

  Future<List<RecentlyPlayedItem>> getPlaylistHistory() async {
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    print("Getting playlist history for user");
    QuerySnapshot qsnap = await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .collection("playlistHistory")
        .getDocuments();

    final fetchedPlaylists = await Future.wait(qsnap.documents.map((elem) =>
        Firestore.instance
            .collection("playlists")
            .document(elem['playlistId'])
            .get()));

    return fetchedPlaylists
        .map((fdoc) => RecentlyPlayedItem(
            id: fdoc.data['playlistId'],
            lastPlayed: fdoc.data['lastPlayed'],
            thumbnailUrl: './images/spotify_smaller.png',
            type: 'playlist',
            title: fdoc.data['playlistName']))
        .toList();
  }
}
