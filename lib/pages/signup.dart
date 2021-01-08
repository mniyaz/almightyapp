import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:almighty/models/contact_model.dart';
import 'package:almighty/pages/login.dart';
import 'package:almighty/services/local_data_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:almighty/routes/page_route.dart';
import 'package:almighty/globals.dart' as globals;

class _SignupPageState extends State<SignupPage> {
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
    _showProgress = false;
  }

  var form = FormGroup({
    'contactFirstName': FormControl<String>(
      validators: [Validators.required],
      touched: true,
    ),
    'contactSecondName': FormControl<String>(
      validators: [Validators.required],
      touched: true,
    ),
    'contactMobile': FormControl<String>(
      validators: [
        Validators.required,
        Validators.number,
        Validators.minLength(10),
        Validators.maxLength(10)
      ],
      touched: true,
    ),
    'contactEmail': FormControl<String>(value: ''),
    'contactAddress': FormControl<String>(value: ''),
    'contactPassword': FormControl<String>(
      validators: [Validators.required],
      touched: true,
    ),
    'contactPasswordConfirm':
        FormControl<String>(validators: [Validators.required]),
  }, validators: [
    Validators.mustMatch('contactPassword', 'contactPasswordConfirm'),
  ]);

  Future<String> signUp() async {
    setState(() {
      _showProgress = true;
    });

    this
        .form
        .value
        .removeWhere((key, value) => key == "contactPasswordConfirm");
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse("https://almightysnk.com/rest/login/signup"));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(this.form.value)));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      setState(() {
        _showProgress = false;
      });
      Fluttertoast.showToast(
          msg: "Singed Up Successfully! Call Almighty to give you access.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        _showProgress = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong! Try again later.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    httpClient.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: ListView(shrinkWrap: true, children: [
      Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
              child: Image.asset('assets/images/AlmightyLogo.png'),
            ),
          ),
        ),
        ReactiveForm(
          formGroup: this.form,
          child: Column(
            children: <Widget>[
              Container(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: ReactiveTextField(
                  formControlName: 'contactFirstName',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                      hintText: 'Enter your first name'),
                ),
              ),
              Container(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: ReactiveTextField(
                  formControlName: 'contactSecondName',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Second Name',
                      hintText: 'Enter your Second name'),
                ),
              ),
              Container(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: ReactiveTextField(
                  formControlName: 'contactMobile',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
                  validationMessages: (control) => {
                    ValidationMessage.minLength: 'Must me 10 digits',
                  },
                ),
              ),
              Container(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: ReactiveTextField(
                    formControlName: 'contactEmail',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email(Optional)',
                    )),
              ),
              Container(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: ReactiveTextField(
                    formControlName: 'contactAddress',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address(Optional)',
                    )),
              ),
              Container(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: ReactiveTextField(
                  obscureText: true,
                  formControlName: 'contactPassword',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: ReactiveTextField(
                  obscureText: true,
                  formControlName: 'contactPasswordConfirm',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password Confirmation',
                  ),
                  validationMessages: (control) => {
                    ValidationMessage.mustMatch: 'Passwords must match',
                  },
                ),
              ),
              Container(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return ButtonTheme(
                      minWidth: 250,
                      height: 50,
                      child: RaisedButton(
                        color: Color(0xFFfa881c),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        // if the form is valid, sign-in or whatever you need to do with the form data (I have used signIn)
                        onPressed: form.valid ? this.signUp : null,
                      ),
                    );
                  },
                ),
              ),
              _showProgress ? CircularProgressIndicator() : new Container(),
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                child: Text(
                  'Go Back',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ],
          ),
        )
      ])
    ]))));
  }

  @override
  void dipose() {
    super.dispose();
  }
}

class SignupPage extends StatefulWidget with ChangeNotifier {
  static const String routeName = '/profile';
  @override
  _SignupPageState createState() => _SignupPageState();
}
