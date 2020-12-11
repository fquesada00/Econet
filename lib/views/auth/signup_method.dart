import 'dart:io';

import 'package:econet/model/my_user.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/services/user.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);
    List<ButtonData> _buttonData = [
      ButtonData(
        'Continue with Google',
        () async {
          print("sign up with google");
          //signup with google
          final credential = await auth.signInWithGoogle();
          //mandar al nuevo usuario a Ecollector o Regular
          sleep(new Duration(seconds: 2));
          Navigator.pushReplacementNamed(context, '/ecollector_or_regular',
              arguments: MyUser.partial(credential.user.displayName,
                  credential.user.email, credential.user.phoneNumber));
        },
        icon: Icon(CustomIcons.google),
        backgroundColor: Color(0xFF4285F4),
      ),
      ButtonData(
        'Continue with Email',
        () {
          Navigator.pushNamed(context, '/signup_email');
        },
        icon: Icon(Icons.email),
        backgroundColor: GREEN_MEDIUM,
      ),
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          NavBar(
              text: 'Sign Up',
              withBack: true,
              backgroundColor: Colors.white,
              textColor: GREEN_MEDIUM,
              height: 120),
          SizedBox(height: size.height * 0.03),
          // para cuando hay muchos metodos
          // Column(
          //     children: _buttonData
          //         .map((btn) => Padding(
          //               padding: const EdgeInsets.all(25.0),
          //               child: Button1(
          //                 btnData: btn,
          //               ),
          //             ))
          //         .toList()),
          Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Button1(
                btnData: _buttonData[0],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Hero(
                tag: 'SignupButton',
                child: Button1(
                  btnData: _buttonData[1],
                ),
              ),
            )
          ])
        ]));
  }
}
