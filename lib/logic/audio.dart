import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  void pickSong(song) async {
    String url = await fetchSongFileUrl(song);
    final res = await audioPlayer.play(url);
    if (res == 1) {
      audioPlayer.play(url);
      isPlaying = true;
      notifyListeners();
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
}
