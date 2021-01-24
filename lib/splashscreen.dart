import 'package:almighty/pages/login.dart';
import 'package:almighty/services/local_data_service.dart';
import 'package:almighty/widgets/tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:almighty/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadFromFuture();
  }

  Future<Widget> loadFromFuture() async {
    String phone = await LocalService.getContactMobile();
    if (phone != null && phone.toString() != "") {
      String password = await LocalService.loadPassword();
      final response = await http.get(
          "https://almightysnk.com/rest/login/login/" +
              phone.toString() +
              "/" +
              password.toString());
      final responseJson = json.decode(response.body);
      if (responseJson["allow"] == "USER AUTHENTICATED") {
        LocalService.saveAPIData(
            globals.AUTH_KEY, responseJson[globals.AUTH_KEY]);
        LocalService.saveAPIData(
            globals.CONTACT_KEY, responseJson[globals.CONTACT_KEY]);
        return Future.value(Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => TabsPage())));
      } else if (responseJson["allow"] == "USER NOT ACTIVE") {
        Fluttertoast.showToast(
            msg: "You are not allowed to login!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return Future.value(Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPage())));
      } else if (responseJson["allow"] == "USER AUTHENTICATION FAILED") {
        Fluttertoast.showToast(
            msg: "Wrong username/password!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return Future.value(Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPage())));
      } else {
        Fluttertoast.showToast(
            msg: "Unable to login!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return Future.value(Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPage())));
      }
    } else {
      return Future.value(Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/AlmightyLogo.png',
                        height: 150,
                        width: 150,
                      ),
                      Container(
                        height: 20,
                      ),
                      new Text(
                        'Welcome To Almighty',
                        style: new TextStyle(fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Container(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
