import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:almighty/models/contact_model.dart';
import 'package:almighty/widgets/tabs_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:almighty/services/local_data_service.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:almighty/globals.dart' as globals;
import 'package:http/http.dart' as http;

class _ProfilePageState extends State<ProfilePage> {
  bool _showProgress = false;
  Contact contact;
  @override
  void initState() {
    super.initState();
    _functionToExecute();
    _showProgress = false;
  }
  var form = FormGroup({
    'contactFirstName': FormControl<String>(validators: [Validators.required],touched: true,),
    'contactSecondName': FormControl<String>(validators: [Validators.required],touched: true,),
    'contactMobile': FormControl<String>(validators: [Validators.required,
      Validators.number,
      Validators.minLength(10),
      Validators.maxLength(10)],touched: true,),
    'contactEmail': FormControl<String>(validators: [Validators.email],touched: true,),
    'contactAddress': FormControl<String>(validators: [Validators.maxLength(200)]),
  });



  _functionToExecute() async {
    setState(() {
      _loading = true;
    });
    final Contact contact = await LocalService.getContact(globals.CONTACT_KEY);
    final authKey = await LocalService.getAuthKey(globals.AUTH_KEY);
    final response = await http.get(
        "https://almightysnk.com/rest/login/getprofile/" +
            contact.contactMobile.toString() +
            "/" +
            authKey.toString());
    if(response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      this.contact = Contact.fromJson(json.decode(responseJson[globals.CONTACT_KEY]));
      LocalService.saveData(globals.CONTACT_KEY, responseJson[globals.CONTACT_KEY]);
      setState(() {
        this.form
            .control("contactFirstName")
            .value = this.contact.contactFirstName;
        this.form
            .control("contactSecondName")
            .value = this.contact.contactSecondName;
        this.form
            .control("contactMobile")
            .value = this.contact.contactMobile;
        this.form
            .control("contactEmail")
            .value = this.contact.contactEmail;
        this.form
            .control("contactAddress")
            .value = this.contact.contactAddress;
      });
    }else{
      Fluttertoast.showToast(
          msg: "Unable to get your profile! Try again later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    setState(() {
      _loading = false;
    });
  }

  Future<String> signUp() async {
    setState(() {
      _showProgress = true;
    });
    contact.contactFirstName = this.form.control("contactFirstName").value;
    contact.contactSecondName = this.form.control("contactSecondName").value;
    contact.contactMobile = this.form.control("contactMobile").value;
    contact.contactEmail = this.form.control("contactEmail").value ;
    contact.contactAddress = this.form.control("contactAddress").value;
    var jsonRequest = json.decode(json.encode(contact));
    jsonRequest.removeWhere((key, value) => key == "authKey");
    jsonRequest.removeWhere((key, value) => key == "contactPassword");
    jsonRequest.removeWhere((key, value) => key == "contactActive");
    jsonRequest.removeWhere((key, value) => key == "contactGroup");
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse("https://almightysnk.com/rest/login/signup"));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonRequest)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();

    if(response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Updated Successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if (response.statusCode == 401) {
      Fluttertoast.showToast(
          msg: "You are not authorized!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      print(reply);
      Fluttertoast.showToast(
          msg: "Unable to update profile. Try again later!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    setState(() {
      _showProgress = false;
    });
    httpClient.close();
  }
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _loading ? bodyProgress :
    SafeArea(child:
    Center( child:
    ListView(
        shrinkWrap: true,
        children : [
          Column(children: [Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Center(
              child: Container(
                  width: 100,
                  height: 100,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset('assets/images/AlmightyLogo.png')),
            ),
          ),
            ReactiveForm(
              formGroup: this.form,
              child: Column(
                children: <Widget>[
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child:ReactiveTextField(
                      formControlName: 'contactFirstName',
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                          hintText: 'Enter your first name'),
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child:ReactiveTextField(
                      formControlName: 'contactSecondName',
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Second Name',
                          hintText: 'Enter your Second name'),
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child:ReactiveTextField(
                      formControlName: 'contactMobile',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',),
                      validationMessages: (control) => {
                        ValidationMessage.minLength: 'Must me 10 digits',

                      },
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child:ReactiveTextField(
                        formControlName: 'contactEmail',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email(Optional)',)
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child:ReactiveTextField(
                        formControlName: 'contactAddress',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Address(Optional)',)
                    ),
                  ),

                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child:ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return ButtonTheme(
                            minWidth: 250,
                            height: 50,
                            buttonColor: Colors.blue,
                            child:RaisedButton(

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),

                              ),
                              child: Text('Update',
                                style: TextStyle(color: Colors.white, fontSize: 25),),
                              // if the form is valid, sign-in or whatever you need to do with the form data (I have used signIn)
                              onPressed: form.valid ? this.signUp : null,
                            ));

                      },
                    ),),
                  _showProgress ? CircularProgressIndicator() : new Container(),
                  FlatButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TabsPage()));
                    },
                    child: Text(
                      'Go Back',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ],
              ),
            )])]))
    )
    );
  }


  @override
  void dipose(){
    super.dispose();
  }

  var bodyProgress = new Container(
    child: new Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "trying to load your profile...",
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class ProfilePage extends StatefulWidget with ChangeNotifier{
  static const String routeName = '/profile';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}