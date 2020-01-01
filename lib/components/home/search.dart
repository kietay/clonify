import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/search.dart';

// todo refactor to one class per file
class SearchResult extends StatelessWidget {
  SearchResult(this.title, this.subtitle);

  final String title;
  final String subtitle;

  @override
  build(context) => Card(
          child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: GestureDetector(
          child: Icon(Icons.more_vert),
          onTap: () => print('Card clicked'),
          onLongPress: () => print('Pressed me even longer'),
        ),
      ));
}

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  build(context) => Padding(
      padding: EdgeInsets.all(4.0),
      child: TextField(
        onChanged: (value) => print(value),
        controller: editingController,
        decoration: InputDecoration(
            labelText: "Searchamundo",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ));
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchLogic = Provider.of<SearchLogic>(context);

    if (!searchLogic.songsLoaded) searchLogic.newSearchScreen();

    var songs = searchLogic.songs;

    return SafeArea(
        key: ValueKey<int>(2),
        child: !searchLogic.songsLoaded
            ? CircularProgressIndicator()
            : Column(children: [
                SearchBar(),
                Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: songs.length,
                      itemBuilder: (context, ind) => SearchResult(
                          songs[ind].songTitle, songs[ind].performedBy),
                    ),
                    padding: EdgeInsets.all(4.0)),
              ]));
  }
}
