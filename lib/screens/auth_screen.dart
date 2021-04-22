import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/auth/auth_gmail.dart';

import './reg_form_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // var _isLoading = false;
  // final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _createUser(
    String email,
    String uid,
    String username,
    String url,
  ) async {
    Navigator.of(context).pushNamed(RegFormScreen.routename);

    // await firestore.collection('user').doc(uid).set({
    //   'username': username,
    //   'email': email,
    //   'uid': uid,
    //   'image_url': url,
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: AuthGmail(_createUser),
        ));
  }
}
