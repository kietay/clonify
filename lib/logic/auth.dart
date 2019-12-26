import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/components/clonify_home.dart';
import 'package:clonify/logic/basic_ui.dart';

class SessionManagement extends ChangeNotifier {
  FirebaseUser fUser;

  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      print("No User");
      return null;
    } else {
      print("Current User : " + user.uid);
      return user;
    }
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("Logged out!");
      return true;
    } catch (e) {
      print("Could not log out!");
      return false;
    }
  }
}

class LoginLogic extends ChangeNotifier {
  bool loginButton = false;
  bool showPassword = false;
  bool isAuthenticating = false;

  String email, password;

  void showPassFun() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void loginButtonListener(String username, String password) {
    if (username.length > 5 && password.length > 5) {
      loginButton = true;
      notifyListeners();
    } else {
      loginButton = false;
      notifyListeners();
    }
  }

  void loginIn(BuildContext context, String email, String pass) async {
    print("Username : " + email + "Password : " + pass);
    isAuthenticating = true;
    notifyListeners();
    try {
      AuthResult res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = res.user;
      print(user.uid);
      isAuthenticating = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        builder: (_) => SessionManagement(),
                      )
                    ],
                    child: ClonifyHome(),
                  )),
          (Route<dynamic> route) => false);
    } catch (e) {
      final ShowCustomAlertDialog showCustomAlertDialog =
          ShowCustomAlertDialog();
      print("Catch Error : " + e.message);
      showCustomAlertDialog.showCustomDialog(context, e.message);
      isAuthenticating = false;
      loginButton = false;
      notifyListeners();
    }
  }
}

class LogoutLogic extends ChangeNotifier {
  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}

class CreateUserAccount extends ChangeNotifier {
  final PageController pctrl = PageController(initialPage: 0);
  bool emailNextEnabled = false;
  bool passNextEnabled = false;
  bool nameNextEnabled = false;

  bool isCreatingAccount = false;

  bool showPassword = false;
  String name, email, password;

  void emailNextButtonListener(String text) {
    if (text.length > 5) {
      emailNextEnabled = true;
    } else {
      emailNextEnabled = false;
    }
    notifyListeners();
  }

  void passNextButtonListener(String text) {
    if (text.length > 6) {
      passNextEnabled = true;
    } else {
      passNextEnabled = false;
    }
    notifyListeners();
  }

  void nameNextButtonListener(String text) {
    if (text.length > 6) {
      nameNextEnabled = true;
    } else {
      nameNextEnabled = false;
    }
    notifyListeners();
  }

  void showPassFun() {
    showPassword = !showPassword;
    notifyListeners();
  }

  Future<bool> signUp(
      BuildContext context, String name, String email, String password) async {
    isCreatingAccount = true;
    notifyListeners();
    try {
      AuthResult signUpRes = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = signUpRes.user;
      print("Signed up as : " + user.uid);
      await Firestore.instance.collection("users").document(user.uid).setData({
        "name": name,
        "nameIndex": name[0],
        "premiumMember": false,
        "email": email,
        "uid": user.uid
      });
      isCreatingAccount = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        builder: (_) => SessionManagement(),
                      )
                    ],
                    child: ClonifyHome(),
                  )),
          (Route<dynamic> route) => false);
      return true;
    } catch (e) {
      final ShowCustomAlertDialog showCustomAlertDialog =
          ShowCustomAlertDialog();
      print(e.message);
      isCreatingAccount = false;
      notifyListeners();
      showCustomAlertDialog.showCustomDialog(context, e.message);
      return false;
    }
  }
}

class ForgotPassword extends ChangeNotifier {
  String email;
  ShowCustomAlertDialog showCustomAlertDialog = ShowCustomAlertDialog();
  bool getLinkEnable = false;
  void buttonActivateListener(String text) {
    //print(text);
    email = text;
    if (text.length > 5) {
      getLinkEnable = true;
      notifyListeners();
    } else {
      getLinkEnable = false;
      notifyListeners();
    }
  }

  Future<bool> sendEmail(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.message);
      showCustomAlertDialog.showCustomDialog(context, e.message);
      return false;
    }
  }
}
