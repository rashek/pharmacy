import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  static final String routename = 'home_screen';
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('LogOut'),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              googleSignIn.disconnect();
              googleSignIn.signOut();
            },
          ),
        ));
  }
}
