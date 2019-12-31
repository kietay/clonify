import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/auth.dart';
import 'package:clonify/components/admin.dart';
import 'package:clonify/components/user.dart';
import 'package:clonify/logic/audio.dart';

class ClonifyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionObject = Provider.of<SessionManagement>(context);
    final audioProvider = Provider.of<AudioProvider>(context);

    final bottomBarItem = (icon, text, onTap) => GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon),
            Text(text),
          ],
        ));

    final settingsButton = GestureDetector(
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.settings),
        ),
      ),
      onTap: () {
        print("Settings clicked");
      },
    );

    return Scaffold(
      appBar: AppBar(
          title: const Text("Clonify"),
          backgroundColor: Colors.green.withOpacity(0.5),
          bottomOpacity: 1,
          textTheme: const TextTheme(
              title: TextStyle(fontFamily: 'ProximaNovaBold', fontSize: 30.0)),
          leading: GestureDetector(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.person),
              ),
            ),
            onTap: () {
              print("Person clicked");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiProvider(providers: [
                          ChangeNotifierProvider(
                            create: (_) => SessionManagement(),
                          ),
                        ], child: UserAdmin())),
              );
            },
          ),
          actions: [settingsButton]),
      bottomNavigationBar: Container(
        height: 60.0,
        color: Colors.grey.withOpacity(0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            bottomBarItem(
                Icons.home, 'Home', () => sessionObject.changeScreen('home')),
            bottomBarItem(Icons.search, 'Search',
                () => sessionObject.changeScreen('search')),
            bottomBarItem(Icons.library_music, 'Library',
                () => sessionObject.changeScreen('library')),
            bottomBarItem(Icons.lock, 'Admin', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpotifyAdmin()),
              );
            }),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(child: child, scale: animation);
        },
        child: sessionObject.screens[sessionObject.currentScreen],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Floating action button pressed");
          audioProvider.playButton();
        },
        tooltip: 'Increment Counter',
        child: Icon(!audioProvider.isPlaying ? Icons.play_arrow : Icons.pause),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
