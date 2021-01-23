import 'package:almighty/pages/home.dart';
import 'package:almighty/pages/login.dart';
import 'package:almighty/pages/profile.dart';
import 'package:almighty/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:almighty/routes/page_route.dart';


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
      home: SplashScreen(),
      routes: {
        pageRoutes.profile: (context) => ProfilePage(),
        pageRoutes.login: (context) => LoginPage(),
        pageRoutes.home: (context) => HomePage(),
      },
    );
  }
}