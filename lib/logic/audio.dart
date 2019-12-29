import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Audio extends ChangeNotifier {
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

  void playSong() async {
    String url = await fetchSongFileUrl(songKey);
    await audioPlayer.play(url);
  }

  void pauseSong() async {
    await audioPlayer.pause();
  }
}
