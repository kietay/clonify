import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) => SafeArea(
      key: ValueKey<int>(2),
      child: Column(children: [
        SearchBar(),
        Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                // todo make this a listview builder for search results
                SearchResult("Song One", "Kendrick Lamar"),
                SearchResult("Song Two", "Judge Judy"),
              ],
            ),
            padding: EdgeInsets.all(4.0)),
      ]));
}
