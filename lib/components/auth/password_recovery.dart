import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/auth_logic.dart';

class PasswordRecovery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forgotObj = Provider.of<ForgotPassword>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          "Forgot password?",
          style: TextStyle(
            fontFamily: 'ProximaNovaBold',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Email or username",
              style: TextStyle(
                fontFamily: 'ProximaNovaBold',
                fontSize: 35.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                focusColor: Colors.black,
                contentPadding: EdgeInsets.all(16.0),
                fillColor: Colors.grey,
                filled: true,
                border: OutlineInputBorder(),
                disabledBorder: InputBorder.none,
              ),
              onChanged: (String text) {
                forgotObj.buttonActivateListener(text);
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
                "We'll send a link to your email that will let you reset your password"),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 20.0),
                color: forgotObj.getLinkEnable ? Colors.white : Colors.grey,
                onPressed: () async {
                  forgotObj.getLinkEnable
                      ? (await forgotObj.sendEmail(context, forgotObj.email))
                          ? forgotObj.showCustomAlertDialog.showCustomDialog(
                              context,
                              "An email was sent to you to reset your password")
                          : print("Something went wrong")
                      : forgotObj.showCustomAlertDialog.showCustomDialog(
                          context, "Please enter a valid email");
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Text(
                  "Get link",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'ProximaNovaBold',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
