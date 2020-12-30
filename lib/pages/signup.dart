import 'package:almighty/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class _SignupPageState extends State<SignupPage> {

  final form = FormGroup({
    'contactFirstName': FormControl<String>(validators: [Validators.required]),
    'contactSecondName': FormControl<String>(validators: [Validators.required]),
    'contactMobile': FormControl<String>(validators: [Validators.required,
      Validators.number,
      Validators.minLength(10),
      Validators.maxLength(10)]),
    'contactEmail': FormControl<String>(value: ''),
    'contactAddress': FormControl<String>(value: ''),
    'contactPassword': FormControl<String>(validators: [Validators.required]),
    'contactPasswordConfirm': FormControl<String>(validators: [Validators.required]),
  },validators: [Validators.mustMatch('contactPassword', 'contactPasswordConfirm'),]);

  void signUp() {
    final credentials = this.form.value;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
       SafeArea(child:
       ListView(
       shrinkWrap: true,
       children : [
       Column(children: [Padding(
           padding: const EdgeInsets.only(top: 10.0),
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
        child:ReactiveTextField(
          obscureText: true,
            formControlName: 'contactPassword',
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',),
          ),
      ),
      Padding(
        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 15, bottom: 0),
        child:ReactiveTextField(
          obscureText: true,
            formControlName: 'contactPasswordConfirm',
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password Confirmation',),
          validationMessages: (control) => {
            ValidationMessage.mustMatch: 'Passwords must match',

          },
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
                child: Text('Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 25),),
                // if the form is valid, sign-in or whatever you need to do with the form data (I have used signIn)
                onPressed: form.valid ? this.signUp : null,
              ));

            },
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
    )])])
      )
    );
  }
}

class SignupPage extends StatefulWidget with ChangeNotifier{
  static const String routeName = '/profile';
  @override
  _SignupPageState createState() => _SignupPageState();
}
