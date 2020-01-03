import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Admin extends ChangeNotifier {
  String name, coverUrl;
  Future<int> addArtist(String name, String imageUrl) async {
    QuerySnapshot qsnap = await Firestore.instance
        .collection("artists")
        .where("name", isEqualTo: name.toLowerCase())
        .getDocuments();

    if (qsnap.documents.length != 0) {
      print('Artist already exists sorry mate');
      return -1;
    } else {
      var ref = Firestore.instance.collection("artists").document();
      ref.setData({
        "artistId": ref.documentID,
        "name": name.toLowerCase(),
        "followers": 0,
        "monthlyListerners": 0,
        "coverImageUrl": imageUrl
      }).then((doc) {
        print("New artist added");
      }).catchError((e) {
        print("Could not add new artist:" + e);
      });
      return 1;
    }
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

  Map<String, String> newSongData = {};

  void addSong() {
    var ref = Firestore.instance.collection("songs").document();

    newSongData['songId'] = ref.documentID;

    ref.setData(newSongData).then((doc) {
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
