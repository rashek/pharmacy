import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/reg_form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (userSnapshot.hasData) {
            return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('user')
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser.uid)
                    .get(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SplashScreen();
                  }
                  if (snapshot.data.docs.length == 0) {
                    return RegFormScreen();
                  }
                  return MyHomePage();
                });
            // return ChatScreen();
          }
          return AuthScreen();
        },
      ),
      routes: {
        RegFormScreen.routename: (ctx) => RegFormScreen(),
      },
      // ,
    );
  }
}

class MyHomePage extends StatelessWidget {
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
