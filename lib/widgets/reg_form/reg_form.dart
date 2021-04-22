import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegForm extends StatefulWidget {
  @override
  _RegFormState createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  final _formKey = GlobalKey<FormState>();

  bool _toogleVisibility = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String _email;
  String _mobileNumber;
  String _password;
  String _drugLicence;
  String _address;
  String _firstName;
  String _lastName;
  String _dateOfBirth;
  String _gender;
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height - mediaQuery.padding.top;
    final width = mediaQuery.size.width;
    return ListView(
      children: <Widget>[
        SizedBox(
          height: height * 0.05,
        ),
        Center(
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/use_profile_avatar_male_image.png',
            ),
            radius: width * 0.18,
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Center(
          child: Text(
            'আপনার ছবি দিন',
            style: TextStyle(
                color: Color(0xff24d39b),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'আপনার নাম দিন',
                      labelText: 'নাম'),
                  controller: lastNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'আপনার নাম দিন';
                    }
                    if (value.length < 3) {
                      return 'আপনার নামের বানানে সর্বনিন্ম ৩ টি অক্ষর থাকতে হবে';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'আপনার ঠিকানা দিন',
                      labelText: 'ঠিকানা'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'আপনার ঠিকানা দিন';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _address = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'yyyy-mm-dd',
                      labelText: 'জন্ম তারিখ'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'আপনার জন্ম তারিখ দিন';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _dateOfBirth = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: DropdownButton<String>(
                  hint: Text('আপনার জেন্ডার নির্বাচন করুন'),
                  items: <String>['Male', 'Female'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _gender = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'আপনার মোবাইল নাম্বার দিন',
                      labelText: 'মোবাইল নাম্বার'),
                  validator: (value) {
                    bool mobileNumberValid =
                        RegExp(r'(^(01){1}[3-9]{1}\d{8})$').hasMatch(value);
                    if (value.isEmpty) {
                      return 'আপনার মোবাইল নাম্বার দিন';
                    }
                    if (mobileNumberValid != true) {
                      return 'আপনার মোবাইল নাম্বার সঠিক নয়';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _mobileNumber = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'আপনার ট্রেড লাইসেন্স নাম্বার দিন',
                      labelText: 'ট্রেড লাইসেন্স নাম্বার'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'আপনার ট্রেড লাইসেন্স নাম্বার দিন';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _drugLicence = value;
                  },
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 12),
                child: RawMaterialButton(
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: height * 0.005,
        ),
      ],
    );
  }
}
