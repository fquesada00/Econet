import 'dart:io';

import 'package:econet/model/my_user.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/user.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupEmail extends StatefulWidget {
  @override
  _SignupEmailState createState() => _SignupEmailState();
}

class _SignupEmailState extends State<SignupEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NavBar(
              text: 'Sign Up',
              withBack: true,
              backgroundColor: Colors.white,
              textColor: GREEN_MEDIUM,
              height: 120,
            ),
            _EmailRegisterForm(),
          ],
        ),
      ),
    );
  }
}

class _FieldTemplateData {
  final String labelText;
  final Icon icon;
  TextEditingController controller;
  final TextInputType keyboardType;

  _FieldTemplateData(
      {@required this.labelText,
      this.icon,
      this.controller,
      this.keyboardType});
}

class _EmailRegisterForm extends StatefulWidget {
  @override
  __EmailRegisterFormState createState() => __EmailRegisterFormState();
}

class __EmailRegisterFormState extends State<_EmailRegisterForm> {
  static TextEditingController nameController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController();

  List<_FieldTemplateData> fieldData = [
    _FieldTemplateData(
        labelText: 'Full Name',
        icon: Icon(Icons.person),
        controller: nameController,
        keyboardType: TextInputType.name),
    _FieldTemplateData(
        labelText: 'Email Address',
        icon: Icon(Icons.email),
        controller: emailController,
        keyboardType: TextInputType.emailAddress),
    _FieldTemplateData(
        labelText: 'Phone Number',
        icon: Icon(Icons.phone),
        controller: phoneNumberController,
        keyboardType: TextInputType.phone),
    _FieldTemplateData(
        labelText: 'Password',
        icon: Icon(Icons.lock),
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword),
  ];

  String errorMessage = "";
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: fieldData
                .map((field) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 5),
                      child: TextFormField(
                        keyboardType: field.keyboardType,
                        controller: field.controller,
                        textInputAction: field.labelText.toLowerCase() ==
                                'password' // Si es el ultimo field, tiene que dar la opcion de Done
                            ? TextInputAction.done
                            : TextInputAction.next,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        obscureText:
                            (field.labelText.toLowerCase() == 'password')
                                ? !_passwordVisible
                                : false,
                        decoration: InputDecoration(
                          labelText: field.labelText,
                          labelStyle: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontSize: 20,
                          ),
                          suffixIcon:
                              field.labelText.toLowerCase() == 'password'
                                  ? IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      })
                                  : null,
                          icon: field.icon,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                    ))
                .toList(),
          ),
        ),

        // Para cuando hayan terms & conditions...
        // SafeArea(
        //   child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        //       child: RichText(
        //           textAlign: TextAlign.center,
        //           text: TextSpan(
        //               text: "By continuing, you agree to Econet's ",
        //               style: TextStyle(
        //                 color: Colors.black,
        //               ),
        //               children: <TextSpan>[
        //                 TextSpan(
        //                     text: 'Terms & Conditions',
        //                     style: TextStyle(color: GREEN_DARK)),
        //                 TextSpan(text: ' and '),
        //                 TextSpan(
        //                     text: 'Privacy Policy',
        //                     style: TextStyle(color: GREEN_DARK)),
        //               ]))),
        // ),
        SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.only(left: 45, right: 45, bottom: 30),
          child: Hero(
            tag: 'SignupButton',
            child: Button1(
                btnData: ButtonData(
              'SIGN UP',
              () async {
                if (_formKey.currentState.validate()) {
                  print('FORM: OK');
                  errorMessage = await auth.registerWithEmailAndPassword(
                      emailController.text, passwordController.text);
                  print(errorMessage);
                  sleep(new Duration(seconds: 3));
                  if (errorMessage.trim() == "successfully logged in") {
                    print("DID IT");
                    //Navigator.popUntil(context, ModalRoute.withName('/auth'));
                    Navigator.pushReplacementNamed(
                        context, '/ecollector_or_regular',
                        arguments: MyUser.partial(
                            nameController.text,
                            emailController.text,
                            phoneNumberController.text));
                  } else {
                    String snackMessage = errorMessage;

                    switch (errorMessage) {
                      case 'weak-password':
                        snackMessage =
                            'Password should be at least 6 characters long';
                        break;
                      case 'invalid-email':
                        snackMessage = 'Please enter a valid email address';
                        break;
                    }

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Center(
                        heightFactor: 1,
                        child: Text(
                          snackMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ));
                  }
                  print(errorMessage);
                  setState(() {});
                }
              },
              backgroundColor: GREEN_MEDIUM,
            )),
          ),
        ),
      ],
    );
  }
}
