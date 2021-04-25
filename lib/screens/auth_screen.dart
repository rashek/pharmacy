import 'package:flutter/material.dart';
import '../widgets/auth/auth_gmail.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: AuthGmail(),
        ));
  }
}
