import 'package:clonify/models/song.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Suggestion {
  Suggestion(this.title, this.fetchLogic);

  final String title;
  final Function() fetchLogic;

  List<Song> songs = [];
}

class Suggestions extends ChangeNotifier {
  bool itemsFetched = false;

  List<Suggestion> suggestions = [];

  Suggestions() {
    suggestions.add(Suggestion('Recently played', fillSongHistory));
  }

  void fetchHomeScreen() async {
    // Populate all suggestion categories with songs
    await Future.wait(suggestions.map((s) async {
      final items = await s.fetchLogic();
      s.songs += items;
    }));
    itemsFetched = true;
    notifyListeners();
  }

  Future<String> fetchSongImageUrl(file) async {
    String url =
        await FirebaseStorage.instance.ref().child(file).getDownloadURL();
    return url;
  }

  Future<List<Song>> fillSongHistory() async {
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

      return Song(
          songId: songDoc.data['songId'],
          thumbnailUrl: await fetchSongImageUrl(songDoc.data['thumbnailUrl']),
          songTitle: songDoc.data['songTitle'],
          performedBy: songDoc.data['performedBy'],
          audioUrl: songDoc.data['audioUrl']);
    }));

    return fetchedSongs.toList();
  }
}
