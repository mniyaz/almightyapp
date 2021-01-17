import 'package:almighty/pages/home.dart';
import 'package:almighty/pages/login.dart';
import 'package:almighty/pages/profile.dart';
import 'package:almighty/services/local_data_service.dart';
import 'package:almighty/widgets/tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:almighty/routes/page_route.dart';
import 'package:almighty/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Almighty App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Color(0xFF00b447),
        accentColor: Color(0xFFfa881c),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFfa881c),
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Almighty app'),
      routes: {
        pageRoutes.profile: (context) => ProfilePage(),
        pageRoutes.login: (context) => LoginPage(),
        pageRoutes.home: (context) => HomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  Future<Widget> loadFromFuture() async {
    final phone = await FlutterSession().get(globals.PHONE);
    if (phone != null && phone.toString() != "") {
      String password = await FlutterSession().get(globals.PASSWORD);
      final response = await http.get(
          "https://almightysnk.com/rest/login/login/" +
              phone.toString() +
              "/" +
              password.toString());
      final responseJson = json.decode(response.body);
      if (responseJson["allow"] == "USER AUTHENTICATED") {
        LocalService.saveData(globals.AUTH_KEY, responseJson[globals.AUTH_KEY]);
        LocalService.saveData(
            globals.CONTACT_KEY, responseJson[globals.CONTACT_KEY]);
        return Future.value(Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => TabsPage())));
      } else if (responseJson["allow"] == "USER NOT ACTIVE") {
        Fluttertoast.showToast(
            msg: "You are not allowed to login!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return Future.value(Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => LoginPage())));
      } else if (responseJson["allow"] == "USER AUTHENTICATION FAILED") {
        Fluttertoast.showToast(
            msg: "Wrong username/password!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return Future.value(Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => LoginPage())));
      } else {
        Fluttertoast.showToast(
            msg: "Unable to login!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return Future.value(Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => LoginPage())));
      }
    }else{
      return Future.value(Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => LoginPage())));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SplashScreen(
        navigateAfterFuture: loadFromFuture(),
        title: new Text(
          'Welcome To Almighty',
          style: new TextStyle(fontSize: 20.0),
        ),
        useLoader: true,
        image: new Image.asset("assets/images/AlmightyLogo.png"),
        backgroundColor: Colors.white,
        photoSize: 100.0,
      ),
    );
  }
}
