import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vm_rider/screens/loginscreen.dart';
import 'package:vm_rider/screens/mainscreen.dart';
import 'package:vm_rider/screens/signupscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// ignore: deprecated_member_use
DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vromood Rider',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.cyan,
      ),
      initialRoute: MainScreen.idScreen,
      routes: {
        SignupScreen.idScreen: (context) => SignupScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        MainScreen.idScreen: (context) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
