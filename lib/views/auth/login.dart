import 'package:econet/views/widgets/button_data.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/presentation/custom_icons_icons.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
      children: <Widget>[
          NavBar(
            text: 'Log In',
            withBack: true,
            backgroundColor: Colors.white,
            textColor: BROWN_MEDIUM,
            height: 120,
          ),
      ],
    ));
  }
}
