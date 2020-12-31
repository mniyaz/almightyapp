import 'package:almighty/pages/login.dart';
import 'package:almighty/pages/otp_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                    hintText: 'Enter valid email phone number as 9999999999'),
              ),
            ),
      Padding(
        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 15, bottom: 0),
        child:Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => OtpPage()));
                },
                child: Text(
                  'Get OTP',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),),
            FlatButton(
              onPressed: (){
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
      ),)
    );
  }
}