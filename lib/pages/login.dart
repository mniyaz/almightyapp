import 'package:almighty/pages/forgot_password.dart';
import 'package:almighty/pages/signup.dart';
import 'package:almighty/services/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:almighty/widgets/tabs_page.dart';
import 'package:almighty/services/local_data_service.dart';
import 'package:almighty/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showProgress = false;
  bool _passwordVisible;
  bool sessionAvailable = false;

  @override
  void initState() {
    checkSession();
    _passwordVisible = false;
    super.initState();
  }

  checkSession() async {
    String phone = await LocalService.getContactMobile();
    if (phone != "") {
      sessionAvailable = true;
    } else {
      sessionAvailable = false;
    }
  }

  final form = FormGroup({
    'phone': FormControl(
      validators: [
        Validators.required,
        Validators.number,
        Validators.minLength(10),
        Validators.maxLength(10)
      ],
      touched: true,
    ),
    'password': FormControl(
      validators: [Validators.required],
      touched: true,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Center(
                    child: Container(
                        width: 150,
                        height: 150,
                        /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                        child: Image.asset('assets/images/AlmightyLogo.png')),
                  ),
                ),
                new Container(
                  height: 50,
                ),
                ReactiveForm(
                  formGroup: this.form,
                  child: Column(
                    children: <Widget>[
                      Container(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ReactiveTextField(
                          formControlName: 'phone',
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone',
                              hintText:
                                  'Enter valid email phone number as 9999999999'),
                          validationMessages: (control) => {
                            ValidationMessage.minLength: 'Must me 10 digits',
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ReactiveTextField(
                          formControlName: 'password',
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter secure password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ForgotPasswordPage()),
                          );
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                      Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: ReactiveFormConsumer(
                            builder: (context, form, child) {
                              return FlatButton(
                                onPressed: form.valid
                                    ? () {
                                        setState(() {
                                          _showProgress = true;
                                        });
                                        signIn(context);
                                      }
                                    : null,
                                child: Text(
                                  'Login'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              );
                            },
                          )),
                      _showProgress
                          ? CircularProgressIndicator()
                          : new Container(),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignupPage()));
                        },
                        child: Text('New User? Create Account'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> signIn(context) async {
    final response = await http.get(
        "https://almightysnk.com/rest/login/login/" +
            this.form.control('phone').value.toString() +
            "/" +
            this.form.control('password').value.toString());
    final responseJson = json.decode(response.body);
    if (responseJson["allow"] == "USER AUTHENTICATED") {
      LocalService.saveAPIData(
          globals.AUTH_KEY, responseJson[globals.AUTH_KEY]);
      LocalService.saveAPIData(
          globals.PASSWORD, this.form.control('password').value.toString());
      LocalService.saveAPIData(
          globals.CONTACT_KEY, responseJson[globals.CONTACT_KEY]);
      PushNotificationsManager pM = new PushNotificationsManager();
      await pM.init();
      setState(() {
        _showProgress = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => TabsPage()));
    } else if (responseJson["allow"] == "USER NOT ACTIVE") {
      setState(() {
        _showProgress = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("You are not allowed to login!"),
      ));
    } else if (responseJson["allow"] == "USER AUTHENTICATION FAILED") {
      setState(() {
        _showProgress = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Wrong username/password!"),
      ));
    } else if (responseJson["allow"] == "PASSWORD NOT UPDATED") {
      setState(() {
        _showProgress = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
            "Password is not set for this account. Click forgot password!"),
      ));
    } else {
      setState(() {
        _showProgress = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Unable to login!"),
      ));
    }
  }
}
