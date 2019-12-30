import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RecentlyPlayedItem {
  String id;
  String type;
  DateTime lastPlayed;
  String thumbnailUrl;
  String title;
  String audioUrl;

  RecentlyPlayedItem(
      {this.id,
      this.type,
      this.lastPlayed,
      this.thumbnailUrl,
      this.title,
      this.audioUrl});
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
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    print("Getting song history for user: ${firebaseUser.uid}");
    QuerySnapshot qsnap = await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .collection("songHistory")
        .getDocuments();

    final fetchedSongs = await Future.wait(qsnap.documents.map((elem) async {
      final songDoc = await Firestore.instance
          .collection("songs")
          .document(elem.data['songId'])
          .get();

      return RecentlyPlayedItem(
          id: songDoc.data['songId'],
          lastPlayed: DateTime.fromMillisecondsSinceEpoch(
              elem['lastPlayed'].seconds * 1000),
          thumbnailUrl: await fetchSongImageUrl(songDoc.data['thumbnailUrl']),
          type: 'song',
          title: songDoc.data['songTitle'],
          audioUrl: songDoc.data['audioUrl']);
    }));

    return fetchedSongs.toList();
  }

  Future<List<RecentlyPlayedItem>> getPlaylistHistory() async {
    print("Getting playlist history for user");

    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
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

  Future<String> fetchSongImageUrl(file) async {
    final ref = FirebaseStorage.instance.ref().child(file);
    var url = await ref.getDownloadURL();
    return url;
  }
}
