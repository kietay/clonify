import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clonify/models/song.dart';

class SearchLogic extends ChangeNotifier {
  List<Song> songs = [];
  bool songsLoaded = false;

  void newSearchScreen() async {
    songs = await fetchAllSongs();
    songsLoaded = true;
    notifyListeners();
  }

  void searchButton(searchTerm) async {
    songs = await searchSongs(searchTerm);
    songsLoaded = true;
    notifyListeners();
  }

  Future<List<Song>> fetchAllSongs() async {
    final songQuery =
        await Firestore.instance.collection('songs').getDocuments();

    return songQuery.documents
        .map((doc) => Song(
            songId: doc.data['songId'],
            artistId: doc.data['artistId'],
            songTitle: doc.data['songTitle'],
            audioUrl: doc.data['audioUrl'],
            performedBy: doc.data['performedBy'] != null
                ? doc.data['performedBy']
                : 'Unknown Artist'))
        .toList();
  }

  Future<List<Song>> searchSongs(String searchTerm) async {
    final songQuery =
        await Firestore.instance.collection('songs').getDocuments();

    var docs = songQuery.documents.map((doc) => Song(
        songId: doc.data['songId'],
        artistId: doc.data['artistId'],
        songTitle: doc.data['songTitle'],
        audioUrl: doc.data['audioUrl'],
        performedBy: doc.data['performedBy'] != null
            ? doc.data['performedBy']
            : 'Unknown Artist'));

    return docs
        .where((doc) =>
            doc.songTitle.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }
}
