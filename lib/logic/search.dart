import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clonify/models/song.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  Future<String> fetchSongImageUrl(file) async {
    final ref = FirebaseStorage.instance.ref().child(file);
    var url = await ref.getDownloadURL();
    return url;
  }

  Future<List<Song>> fetchAllSongs() async {
    final songQuery =
        await Firestore.instance.collection('songs').getDocuments();

    var doccos = songQuery.documents
        .map((doc) async => Song(
            songId: doc.data['songId'],
            artistId: doc.data['artistId'],
            songTitle: doc.data['songTitle'],
            audioUrl: doc.data['audioUrl'],
            thumbnailUrl: await fetchSongImageUrl(doc.data['thumbnailUrl']),
            performedBy: doc.data['performedBy'] != null
                ? doc.data['performedBy']
                : 'Unknown Artist'))
        .toList();

    return Future.wait(doccos);
  }

  Future<List<Song>> searchSongs(String searchTerm) async {
    final songQuery =
        await Firestore.instance.collection('songs').getDocuments();

    var docs = songQuery.documents.map((doc) async => Song(
        songId: doc.data['songId'],
        artistId: doc.data['artistId'],
        songTitle: doc.data['songTitle'],
        audioUrl: doc.data['audioUrl'],
        thumbnailUrl: await fetchSongImageUrl(doc.data['thumbnailUrl']),
        performedBy: doc.data['performedBy'] != null
            ? doc.data['performedBy']
            : 'Unknown Artist'));

    var doccos = await Future.wait(docs);

    return doccos
        .where((doc) =>
            doc.songTitle.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }
}
