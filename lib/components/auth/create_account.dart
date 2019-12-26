import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/auth.dart';
import 'package:clonify/logic/basic_ui.dart';

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionObj = Provider.of<CreateUserAccount>(context);
    final uiComponents = Provider.of<ShowCustomAlertDialog>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(
          "Create account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PageView(
        controller: sessionObj.pctrl,
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Email:",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'ProximaNovaBold',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.grey,
                      filled: true,
                      border: OutlineInputBorder()),
                  onChanged: (String text) {
                    sessionObj.emailNextButtonListener(text);
                    sessionObj.email = text;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      sessionObj.emailNextEnabled
                          ? sessionObj.pctrl.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn)
                          : uiComponents.showCustomDialog(
                              context, "Please enter your email");
                    },
                    color: sessionObj.emailNextEnabled
                        ? Colors.white
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text(
                      "next",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'ProximaNovaBold'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Create password",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'ProximaNovaBold',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  obscureText: !sessionObj.showPassword,
                  autofocus: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.grey,
                      filled: true,
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          sessionObj.showPassFun();
                        },
                        icon: sessionObj.showPassword
                            ? Icon(
                                Icons.visibility,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.white,
                              ),
                      )),
                  onChanged: (String text) {
                    sessionObj.passNextButtonListener(text);
                    sessionObj.password = text;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      sessionObj.passNextEnabled
                          ? sessionObj.pctrl.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn)
                          : uiComponents.showCustomDialog(context,
                              "Password must be at least 8 characters");
                    },
                    color:
                        sessionObj.passNextEnabled ? Colors.white : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text(
                      "next",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'ProximaNovaBold'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Name:",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'ProximaNovaBold',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String text) {
                    sessionObj.nameNextButtonListener(text);
                    sessionObj.name = text;
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 5.0),
                  child: Text("This appears on your Clonify profile."),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: sessionObj.isCreatingAccount
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            sessionObj.nameNextEnabled
                                ? sessionObj.signUp(context, sessionObj.name,
                                    sessionObj.email, sessionObj.password)
                                : uiComponents.showCustomDialog(context,
                                    "Name should be at least 6 characters");
                          },
                          color: sessionObj.nameNextEnabled
                              ? Colors.white
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Text(
                            "Create",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontFamily: 'ProximaNovaBold'),
                          ),
                        ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "By creating an account, you agree to Clonify's Terms of Service.",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "To learn more about how Clonify collects, uses, shares and protects your personal data please read Clonify's Privacy Policy",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
