import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/components/admin.dart';
import 'package:clonify/logic/admin_logic.dart';
import 'package:clonify/logic/auth_logic.dart';
import 'package:clonify/logic/basic_ui.dart';
import 'package:clonify/components/auth/create_account.dart';
import 'package:clonify/components/auth/login_page.dart';

class AuthUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            './images/spotify_logo_banner_black.png',
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          Text(
            "Millions of songs. \n Free on Clonify.",
            style: TextStyle(
              fontFamily: 'ProximaNova',
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Continue with",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupOrLogin()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Material(
                                    child: ChangeNotifierProvider(
                                      create: (_) => Admin(),
                                      child: SpotifyAdmin(),
                                    ),
                                  )));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Admin",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignupOrLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromRGBO(255, 0, 254, 100),
          Color.fromRGBO(51, 51, 153, 100),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Email",
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'ProximaNovaBold',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Material(
                                child: MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                      builder: (_) => CreateUserAccount(),
                                    ),
                                    ChangeNotifierProvider(
                                      builder: (_) => ShowCustomAlertDialog(),
                                    ),
                                  ],
                                  child: CreateAccount(),
                                ),
                              )));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 300.0,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text(
                    "Sign up free",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      color: Colors.grey,
                      height: 2.0,
                      width: MediaQuery.of(context).size.width * 0.35,
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.grey,
                      height: 2.0,
                      width: MediaQuery.of(context).size.width * 0.35,
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Material(
                                child: MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                      builder: (_) => LoginLogic(),
                                    ),
                                    ChangeNotifierProvider(
                                      builder: (_) => ShowCustomAlertDialog(),
                                    ),
                                  ],
                                  child: LoginPage(),
                                ),
                              )));
                },
                child: Container(
                  width: 300.0,
                  padding: EdgeInsets.all(12.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
