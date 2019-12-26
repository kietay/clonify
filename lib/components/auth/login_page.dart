import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/auth_logic.dart';
import 'package:clonify/logic/basic_ui.dart';
import 'package:clonify/components/auth/password_recovery.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginLogic = Provider.of<LoginLogic>(context);
    final uiComponents = Provider.of<ShowCustomAlertDialog>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Email or userame",
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'ProximaNovaBold',
              ),
            ),
            SizedBox(
              height: 5.0,
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
                loginLogic.email = text;
                loginLogic.loginButtonListener(
                    loginLogic.email, loginLogic.password);
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Password",
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'ProximaNovaBold',
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextFormField(
              obscureText: !loginLogic.showPassword,
              autofocus: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  fillColor: Colors.grey,
                  filled: true,
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      loginLogic.showPassFun();
                    },
                    icon: loginLogic.showPassword
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
                loginLogic.password = text;
                loginLogic.loginButtonListener(
                    loginLogic.email, loginLogic.password);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: loginLogic.isAuthenticating
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        loginLogic.loginButton
                            ? loginLogic.loginIn(
                                context, loginLogic.email, loginLogic.password)
                            : uiComponents.showCustomDialog(
                                context, "Enter your email and password");
                      },
                      color:
                          loginLogic.loginButton ? Colors.white : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontFamily: 'ProximaNovaBold'),
                      ),
                    ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Material(
                                child: ChangeNotifierProvider(
                                  builder: (context) => ForgotPassword(),
                                  child: PasswordRecovery(),
                                ),
                              )));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 7.0, 30.0, 7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontFamily: 'ProximaNovaBold',
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
