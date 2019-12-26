import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class Admin extends ChangeNotifier {
  String name, coverUrl;
  void addArtist(String name, String imageUrl) {
    var ref = Firestore.instance.collection("artists").document();
    ref.setData({
      "artistId": ref.documentID,
      "name": name,
      "followers": 0,
      "monthlyListerners": 0,
      "coverImageUrl": imageUrl
    }).then((doc) {
      print("New artist added");
    }).catchError((e) {
      print("Could not add new artist:" + e);
    });
  }

  String catName, catImageUrl;
  void addGenre(String name, String thumbnailUrl) {
    var ref = Firestore.instance.collection("genre").document();
    ref.setData({
      "categoryId": ref.documentID,
      "categoryTitle": name,
      "thumbnailUrl": thumbnailUrl,
    }).then((doc) {
      print("Category added");
    }).catchError((e) {
      print("Could not add new genre" + e);
    });
  }

  reloadTheState() {
    notifyListeners();
  }

  String audioName,
      audioUrl,
      performedBy,
      writtenBy,
      producedBy,
      source,
      songThumbnail;
  List<Map<String, dynamic>> lyrics = [];
  Map<String, dynamic> albumofSong;

  //For Searching
  List<DocumentSnapshot> data = [];
  List<DocumentSnapshot> qdata = [];
  List<DocumentSnapshot> catData = [];
  List<DocumentSnapshot> qcatData = [];

  void addSongs(
      String title,
      String audioUrl,
      String performedBy,
      String writtenBy,
      String producedBy,
      String source,
      String artistIdInside,
      String thumbnailUrl,
      List<Map<String, dynamic>> genres,
      List<Map<String, dynamic>> lyrics,
      Map<String, dynamic> albumInfo) {
    var ref = Firestore.instance.collection("songs").document();

    ref.setData({
      "songId": ref.documentID,
      "songTitle": title,
      "releasedTimestamp": DateTime.now(),
      "audioUrl": audioUrl,
      "performedBy": performedBy,
      "writtenBy": writtenBy,
      "producedBy": producedBy,
      "source": source,
      "numberOfPlays": 0,
      "artistId": artistIdInside,
      "genres": genres,
      "lyrics": lyrics,
      "album": albumInfo,
      "thumbnailUrl": thumbnailUrl
    }).then((doc) {
      print("New song added");
    }).catchError((e) {
      print(e);
    });
  }

  String albumTitle, copyrightOwnership, albumThumbnail;
  void addAlbum(String artistId, String title, String copyrightOwnership,
      String albumThumbnail) {
    var ref = Firestore.instance.collection("albums").document();
    ref.setData({
      "albumId": ref.documentID,
      "artistId": artistId,
      "albumTitle": title,
      "releasedTime": DateTime.now(),
      "copyrightOwnership": copyrightOwnership,
      "albumThumbnail": albumThumbnail,
    }).then((doc) {
      print("New album added");
    }).catchError((e) {
      print(e);
    });
  }
}
