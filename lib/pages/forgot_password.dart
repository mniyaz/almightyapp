import 'package:almighty/pages/login.dart';
import 'package:almighty/pages/otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:almighty/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _showProgress = false;
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
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
              child: ReactiveForm(
            formGroup: this.form,
            child: Column(
              children: <Widget>[
                Padding(
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
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ReactiveTextField(
                    formControlName: 'phone',
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        hintText:
                            'Enter valid email phone number as 9999999999'),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child:
                        ReactiveFormConsumer(builder: (context, form, child) {
                      return FlatButton(
                        onPressed: form.valid
                            ? () {
                                setState(() {
                                  _showProgress = true;
                                });
                                getOtp(context);
                              }
                            : null,
                        child: Text(
                          'Get OTP',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      );
                    }),
                  ),
                ),
                _showProgress ? CircularProgressIndicator() : new Container(),
                FlatButton(
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                  child: Text(
                    'Go Back',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ],
            ),
          )),
        ));
  }

  Future<Null> getOtp(context) async {
    final response = await http.get(
        "https://almightysnk.com/rest/login/presignup/" +
            this.form.control('phone').value.toString());
    globals.phone = this.form.control('phone').value.toString();
    final responseJson = json.decode(response.body);
    if (responseJson["allow"]) {
      setState(() {
        _showProgress = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => OtpPage()));
    } else {
      setState(() {
        _showProgress = false;
      });
      Fluttertoast.showToast(
          msg: "You are not allowed to login!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
