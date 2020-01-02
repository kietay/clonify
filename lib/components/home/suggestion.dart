import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/models/song.dart';
import 'package:clonify/logic/audio.dart';
import 'package:clonify/logic/suggestions.dart';

class SuggestionWidget extends StatelessWidget {
  SuggestionWidget(this.suggestion, {Key key}) : super(key: key);

  final Suggestion suggestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 10.0),
            child: Text(suggestion.title,
                style:
                    TextStyle(fontFamily: 'ProximaNovaBold', fontSize: 30.0)),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.30,
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestion.songs.length,
                  itemBuilder: (context, ind) {
                    final song = suggestion.songs[ind];
                    return SuggestionItem(
                        song.songTitle, song.thumbnailUrl, song.audioUrl);
                  }))
        ],
      ),
    );
  }
}

class SuggestionItem extends StatelessWidget {
  SuggestionItem(this.title, this.thumbnailUrl, this.audioUrl, {Key key})
      : super(key: key);

  final itemScale = 0.18;
  final String title;
  final String thumbnailUrl;
  final String audioUrl;

  @override
  build(context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkResponse(
                child: Container(
                  height: MediaQuery.of(context).size.height * itemScale,
                  width: MediaQuery.of(context).size.height * itemScale,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(thumbnailUrl),
                          fit: BoxFit.cover)),
                ),
                onTap: () => audioProvider.pickSong(audioUrl),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(title,
                  style:
                      TextStyle(fontFamily: 'ProximaNovaBold', fontSize: 18.0))
            ]));
  }
}
