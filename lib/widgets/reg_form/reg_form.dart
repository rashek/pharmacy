import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../screens/home_screen.dart';

class RegForm extends StatefulWidget {
  @override
  _RegFormState createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  String _name = '';
  String _address = '';
  String _mobileNumber = '';
  String _drugLicence = '';
  DateTime _dateOfBirth;
  bool dateTimeValidator = false;
  String _gender;
  bool genderValidator = false;
  String uid = FirebaseAuth.instance.currentUser.uid;
  String imageUrl = FirebaseAuth.instance.currentUser.photoURL;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  List listItems = ['Male', 'Female'];

  void submit() async {
    setState(() {
      isLoading = true;
    });
    final isValid = _formKey.currentState.validate();
    if (isValid && _dateOfBirth != null && _gender != null) {
      _formKey.currentState.save();
      await FirebaseFirestore.instance.collection('user').doc(uid).set({
        'uid': uid,
        'email': FirebaseAuth.instance.currentUser.email,
        'user_photo': FirebaseAuth.instance.currentUser.photoURL,
        'name': _name,
        'address': _address,
        'mobile_no': _mobileNumber,
        'drug_license': _drugLicence,
        'DOB': _dateOfBirth,
        'gender': _gender
      });

      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushNamed(HomeScreen.routename);
    }
    if (_dateOfBirth == null) {
      setState(() {
        dateTimeValidator = true;
      });
    }
    if (_dateOfBirth != null) {
      setState(() {
        dateTimeValidator = false;
      });
    }
    if (_gender == null) {
      setState(() {
        genderValidator = true;
      });
    }
    if (_gender != null) {
      setState(() {
        genderValidator = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _setDateOfBirth() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    ).then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        _dateOfBirth = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height - mediaQuery.padding.top;
    final width = mediaQuery.size.width;
    return ListView(
      children: <Widget>[
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: height * 0.05,
              ),
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            //     AssetImage(
            //   'assets/images/use_profile_avatar_male_image.png',
            // ),
            radius: width * 0.18,
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Center(
          child: Text(
            '??????????????? ?????????',
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
                      hintText: '??????????????? ????????? ?????????',
                      labelText: '?????????'),
                  // controller: lastNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '??????????????? ????????? ?????????';
                    }
                    if (value.length < 3) {
                      return '??????????????? ??????????????? ?????????????????? ??????????????????????????? ??? ?????? ??????????????? ??????????????? ?????????';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: '??????????????? ?????????????????? ?????????',
                      labelText: '??????????????????'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return '??????????????? ?????????????????? ?????????';
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
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: '??????????????? ?????????????????? ????????????????????? ?????????',
                      labelText: '?????????????????? ?????????????????????'),
                  validator: (value) {
                    bool mobileNumberValid =
                        RegExp(r'(^(01){1}[3-9]{1}\d{8})$').hasMatch(value);
                    if (value.isEmpty) {
                      return '??????????????? ?????????????????? ????????????????????? ?????????';
                    }
                    if (mobileNumberValid != true) {
                      return '??????????????? ?????????????????? ????????????????????? ???????????? ??????';
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
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: dateTimeValidator ? Colors.red : Colors.grey,
                          width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(_dateOfBirth == null
                              ? 'dd-mm-yyyy'
                              : '${DateFormat.yMd().format(_dateOfBirth)}')),
                      TextButton(
                          onPressed: _setDateOfBirth,
                          child: Text(
                            '??????????????? ???????????? ??????????????? ?????????',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              if (dateTimeValidator)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        '??????????????? ???????????? ??????????????? ?????????',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: genderValidator ? Colors.red : Colors.grey,
                          width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    value: _gender,
                    hint: Text('??????????????? ????????????????????? ???????????????????????? ????????????'),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down_circle),
                    iconSize: 22,
                    isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                    items: listItems.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (genderValidator)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        '??????????????? ????????????????????? ???????????????????????? ????????????',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ],
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
                      hintText: '??????????????? ??????????????? ???????????????????????? ????????????????????? ?????????',
                      labelText: '??????????????? ???????????????????????? ?????????????????????'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return '??????????????? ??????????????? ???????????????????????? ????????????????????? ?????????';
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
                child: ElevatedButton(
                  onPressed: isLoading ? null : submit,
                  child: Text('Submit'),
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
