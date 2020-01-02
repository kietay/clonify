import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AudioProvider extends ChangeNotifier {
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();
  String songKey = 'leftBehind.mp3';

  void initPlayer() {
    audioPlayer.startHeadlessService();
  }

  Future<String> fetchSongFileUrl(key) async {
    final ref = FirebaseStorage.instance.ref().child(key);
    var url = await ref.getDownloadURL();
    return url;
  }

  void pickSong(String songUrl, String songId) async {
    String url = await fetchSongFileUrl(songUrl);
    final res = await audioPlayer.play(url);
    if (res == 1) {
      addToRecentlyPlayed(songId);
      isPlaying = true;
      notifyListeners();
    } else {
      print('Problem playing song');
    }
  }

  void playButton() async {
    if (isPlaying) {
      pauseSong();
    } else {
      playSong();
    }
  }

  void playSong() async {
    String url = await fetchSongFileUrl(songKey);
    final res = await audioPlayer.resume();
    if (res == 1) {
      print("Audio player playing...");
      isPlaying = true;
    } else {
      final pickRandom = await audioPlayer.play(url);
      if (pickRandom != 1)
        print('Error playing audio');
      else
        isPlaying = true;
    }
    notifyListeners();
  }

  void pauseSong() async {
    await audioPlayer.pause();
    print("Audio player paused...");
    isPlaying = false;
    notifyListeners();
  }

  void addToRecentlyPlayed(songId) async {
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    CollectionReference ref = Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('songHistory');

    ref
        .document(songId)
        .setData({'songId': songId, 'lastPlayed': DateTime.now()});
  }
}
