import 'package:flutter/material.dart';

Widget createDrawerHeader() {
  return DrawerHeader(


    child:Center(
      child: Column(
      children : <Widget> [
        Container(
          width: 100,
          height: 100,
          /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
          child: Image.asset('assets/images/AlmightyLogo.png')),
      Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15, bottom: 0),
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child:Text("Almigty e-Shop"),
      ),

    ]),)
      );
}