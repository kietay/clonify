import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clonify/models/song.dart';

class SearchLogic extends ChangeNotifier {
  List<Song> songs = [];
  bool songsLoaded = false;

  void newSearchScreen() async {
    await fetchAllSongs();
    songsLoaded = true;
    notifyListeners();
  }

  Future<List<Song>> fetchAllSongs() async {
    final songQuery =
        await Firestore.instance.collection('songs').getDocuments();

    return songQuery.documents.map((doc) => Song(
        songId: doc.data['songId'],
        artistId: doc.data['artistId'],
        songTitle: doc.data['songTitle'],
        performedBy: doc.data['performedBy']));
  }
}
