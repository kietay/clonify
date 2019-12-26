import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/components/clonify_home.dart';
import 'package:clonify/logic/auth.dart';
import 'package:clonify/components/auth/firebase_session.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future chooseLandingPage() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      print("User not logged in");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Material(
                    child: ChangeNotifierProvider(
                      create: (_) => SessionManagement(),
                      child: FirebaseSession(),
                    ),
                  )));
    } else {
      print("Current User: " + user.uid);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Material(
                    child: MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (_) => SessionManagement(),
                        ),
                      ],
                      child: ClonifyHome(),
                    ),
                  )));
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      chooseLandingPage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset("./images/spotify_logo_title.png"),
      ),
    );
  }
}
