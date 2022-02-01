// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vm_rider/screens/mainscreen.dart';
import 'package:vm_rider/screens/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vm_rider/main.dart';
import 'package:vm_rider/widgets/processdialog.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static const String idScreen = "LoginScreen";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35.0,
            ),
            const Image(
              image: AssetImage("images/logo.png"),
              width: 350.0,
              height: 350.0,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 1.0,
            ),
            const Text(
              "Login as a Rider",
              style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (!emailTextEditingController.text.contains("@")) {
                        displayToastMessage(
                            "Input must be a valid Email", context);
                      }
                      if (passwordTextEditingController.text.length <= 8 &&
                          passwordTextEditingController.text.length <= 5) {
                        displayToastMessage(
                            "Password must be 5-8 characters", context);
                      } else {
                        loginAndAuthUser(context);
                      }
                    },
                    color: Colors.cyan,
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      height: 50.0,
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                  ),
                ],
              ),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignupScreen.idScreen, (route) => false);
                },
                //child: Text("Create a new account"),
                child: const Text(
                  "Creat a new account? Register Here",
                  style: TextStyle(fontFamily: "Brand Solid", fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext) {
          return ProcessDialog(message: "Authenticating! Please Wait...");
        });
    final firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      usersRef
          .child(firebaseUser.uid)
          // ignore: non_constant_identifier_names
          .once()
          .then((DataSnapshot) => {
                if (DataSnapshot != null)
                  {
                    Navigator.pushNamedAndRemoveUntil(
                        context, MainScreen.idScreen, (route) => false),
                    displayToastMessage("You are logged in now", context),
                  }
                else
                  {
                    Navigator.pop(context),
                    _firebaseAuth.signOut(),
                    displayToastMessage(
                        "No user is founed. Please create an account", context)
                  }
                // Navigator.pushNamedAndRemoveUntil(
                //     context, MainScreen.idScreen, (route) => false),
                // displayToastMessage("You are logged in now", context),
              });
    } else {
      Navigator.pop(context);
      displayToastMessage("An Error! Please try again", context);
    }
  }
}
