import 'package:almighty/pages/forgot_password.dart';
import 'package:almighty/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:almighty/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool _showProgress = false;
  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  final form = FormGroup({
    'otp': FormControl(validators: [Validators.required,
      Validators.number,
      Validators.minLength(6),
      Validators.maxLength(6)],
      touched: true,),
    'password': FormControl(validators: [Validators.required],
      touched: true,),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child:SingleChildScrollView(
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
            ),ReactiveForm(
          formGroup: this.form,
          child: Column(
            children: <Widget>[
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ReactiveTextField(
                formControlName: 'otp',
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'OTP',
                    hintText: 'Enter your otp'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: ReactiveTextField(
                formControlName: 'password',
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'New Password',
                    hintText: 'Enter new password',
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
                  ),),
              ),
            ),
            FlatButton(
              onPressed: (){
                setState(() {
                  _showProgress = true;
                });
                getOtp(context);
              },
              child: Text(
                'Resend OTP',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ReactiveFormConsumer(
    builder: (context, form, child) {
    return FlatButton(
                onPressed: form.valid ? () {
                  setState(() {
                    _showProgress = true;
                  });
                  changePassword(context);
                } : null,
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              );
            }),
            ),
              _showProgress ? CircularProgressIndicator() : new Container(),
            FlatButton(
              onPressed: (){
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
              },
              child: Text(
                'Go Back',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
              ]),
  ),
          ],
        ),
      ),)
    );
  }

  Future<Null> getOtp(context) async {
    final response = await http.get(
        "https://almightysnk.com/rest/login/presignup/" + globals.phone.toString());
    final responseJson = json.decode(response.body);
    if (responseJson["allow"]) {
      setState(() {
        _showProgress = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OtpPage()));
    } else  {
      setState(() {
        _showProgress = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("You are not allowed to login!"),
      ));
    }
  }

  Future<Null> changePassword(context) async {
    final response = await http.get(
        "https://almightysnk.com/rest/login/changePassword/" +
            globals.phone.toString()+"/"+this.form.control('otp').value+"/"+this.form.control('password').value.toString());
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      if (responseJson["status"] == "Success") {
        globals.otp = responseJson["otp"];
        setState(() {
          _showProgress = false;
        });
        Fluttertoast.showToast(
            msg: "Password updated successfully!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPage()));
      } else if (responseJson["status"] == "OTP NOT VALID") {
        setState(() {
          _showProgress = false;
        });
        Fluttertoast.showToast(
            msg: "Invalid OTP!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else if (responseJson["status"] == "OTP EXPIRED") {
        setState(() {
          _showProgress = false;
        });
        Fluttertoast.showToast(
            msg: "OTP Expired. Click on Resend Otp button!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }else if (response.statusCode == 401) {
      setState(() {
        _showProgress = false;
      });
      Fluttertoast.showToast(
          msg: "You are not authorised! Check your credentials.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      setState(() {
        _showProgress = false;
      });
      Fluttertoast.showToast(
          msg: "Error: Server did not respond, try again later.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}