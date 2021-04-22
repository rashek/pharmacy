import 'package:flutter/material.dart';

import '../widgets/reg_form/reg_form.dart';

class RegFormScreen extends StatelessWidget {
  static final routename = './reg_form_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: RegForm(),
    );
  }
}
