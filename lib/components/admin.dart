import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/admin.dart';
import 'package:clonify/models/song.dart';

class SpotifyAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => Material(
                                child: ChangeNotifierProvider(
                                  create: (_) => Admin(),
                                  child: AddArtist(),
                                ),
                              )));
                },
                child: ListTile(
                  title: Text("Add a new artist"),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => Material(
                                child: ChangeNotifierProvider(
                                  create: (_) => Admin(),
                                  child: AddCategory(),
                                ),
                              )));
                },
                child: ListTile(
                  title: Text("Add a new category"),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => Material(
                                child: ChangeNotifierProvider(
                                  create: (_) => Admin(),
                                  child: AddSong(),
                                ),
                              )));
                },
                child: ListTile(
                  title: Text("Add a new song"),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => Material(
                                child: ChangeNotifierProvider(
                                  create: (_) => Admin(),
                                  child: AddAlbum(),
                                ),
                              )));
                },
                child: ListTile(
                  title: Text("Create a new album"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddArtist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Artist"),
      ),
      body: Builder(
          builder: (context) => ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Artist Name'),
                          onChanged: (String text) {
                            adminObj.name = text;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Cover Image URL',
                          ),
                          onChanged: (String text) {
                            adminObj.coverUrl = text;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          onPressed: () async {
                            final res = await adminObj.addArtist(
                                adminObj.name, adminObj.coverUrl);
                            if (res == 1) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Artist added congrats mate'),
                                  duration: Duration(seconds: 2)));
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Artist already exists soz'),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: Text("Add Artist"),
                        )
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Category Name'),
                  onChanged: (String text) {
                    adminObj.catName = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category Image URL',
                  ),
                  onChanged: (String text) {
                    adminObj.catImageUrl = text;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    adminObj.addGenre(adminObj.catName, adminObj.catImageUrl);
                  },
                  child: Text("Add Artist"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

String artistId;
List<Map<String, dynamic>> categoriesOfMusic = [];

class AddSong extends StatelessWidget {
  static final List<String> inputFields = [
    'songTitle',
    'performedBy',
    'audioUrl',
    'thumbnailUrl',
  ];

  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Song"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height * 0.5),
              child: ListView.builder(
                  itemCount: inputFields.length,
                  itemBuilder: (context, ind) {
                    return TextFormField(
                        decoration:
                            InputDecoration(labelText: inputFields[ind]),
                        onChanged: (text) =>
                            adminObj.newSongData[inputFields[ind]] = text);
                  })),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => Material(
                                  child: ChangeNotifierProvider(
                                    create: (_) => Admin(),
                                    child: SelectArtist(),
                                  ),
                                )));
                  },
                  child: Container(
                    color: Colors.cyan,
                    padding: EdgeInsets.all(10.0),
                    child: artistId != null
                        ? Text(artistId)
                        : Text("Select Artist"),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Material(
                                  child: ChangeNotifierProvider(
                                    create: (_) => Admin(),
                                    child: SelectCategories(),
                                  ),
                                )));
                  },
                  child: Container(
                    color: Colors.cyan,
                    padding: EdgeInsets.all(10.0),
                    child: categoriesOfMusic.length > 0
                        ? Text(categoriesOfMusic.toString())
                        : Text("Select categories"),
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    print(adminObj.newSongData);
                    adminObj.addSong();
                  },
                  child: Text("Add Song"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AddAlbum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Album"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Album Title'),
                  onChanged: (String text) {
                    adminObj.albumTitle = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Copyright Ownership'),
                  onChanged: (String text) {
                    adminObj.copyrightOwnership = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Thumbnail URL'),
                  onChanged: (String text) {
                    adminObj.albumThumbnail = text;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => Material(
                                  child: ChangeNotifierProvider(
                                    builder: (_) => Admin(),
                                    child: SelectArtist(),
                                  ),
                                )));
                  },
                  child: Container(
                    color: Colors.cyan,
                    padding: EdgeInsets.all(10.0),
                    child: artistId != null
                        ? Text(artistId)
                        : Text("Select the Artist"),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    adminObj.addAlbum(artistId, adminObj.albumTitle,
                        adminObj.copyrightOwnership, adminObj.albumThumbnail);
                  },
                  child: Text("Add Album"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//Tools for Selecting and Searching

class SelectArtist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Artist"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Search'),
                onFieldSubmitted: (String q) async {
                  q = q.toLowerCase();
                  QuerySnapshot qsnap = await Firestore.instance
                      .collection("artists")
                      .where("name", isEqualTo: q.toLowerCase())
                      .getDocuments();
                  adminObj.data = qsnap.documents;
                  adminObj.qdata = adminObj.data;
                  print(adminObj.data);
                  adminObj.reloadTheState();
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: adminObj.qdata.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(adminObj.qdata[i]['name']),
                    subtitle: Text(adminObj.qdata[i]['artistId']),
                    trailing: RaisedButton(
                      color: Colors.black,
                      onPressed: () {
                        artistId = adminObj.qdata[i]['artistId'].toString();
                        Navigator.pop(context);
                      },
                      child: Text("Select"),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Categories"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Search'),
                onChanged: (String q) async {
                  q = q.toUpperCase();
                  if (q.length == 1) {
                    QuerySnapshot qsnap = await Firestore.instance
                        .collection("categories")
                        .where("categoryIndex", isEqualTo: q.toUpperCase())
                        .getDocuments();
                    adminObj.catData = qsnap.documents;
                    adminObj.qcatData = adminObj.catData;
                    adminObj.reloadTheState();
                  } else {
                    adminObj.qcatData = [];
                    for (int i = 0; i < adminObj.catData.length; i++) {
                      //print(adminObj.data[i]['name'].toString().toUpperCase()+ ", Query is : "+q);
                      if (adminObj.catData[i]['name']
                          .toString()
                          .toUpperCase()
                          .contains(q)) {
                        print("Adding some");
                        adminObj.qcatData.add(adminObj.data[i]);
                      }
                    }
                    adminObj.reloadTheState();
                  }
                },
              ),
            ),
            adminObj.qcatData != null
                ? adminObj.qcatData.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: 100.0,
                        child: ListView.builder(
                          itemCount: adminObj.qcatData.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              title:
                                  Text(adminObj.qcatData[i]['categoryTitle']),
                              subtitle:
                                  Text(adminObj.qcatData[i]['categoryId']),
                              trailing: RaisedButton(
                                color: Colors.black,
                                onPressed: () {
                                  categoriesOfMusic.add({
                                    "categoryId": adminObj.qcatData[i]
                                        ['categoryId'],
                                  });
                                },
                                child: Text("Select"),
                              ),
                            );
                          },
                        ),
                      )
                : Text("Start Searching")
          ],
        ),
      ),
    );
  }
}
