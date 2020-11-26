import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/presentation/custom_icons_icons.dart';

class SignUpMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<ButtonData> _buttonData = [
      ButtonData(
        'Continue with Google',
        () {},
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
          Column(
              children: _buttonData
                  .map((btn) => Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Button1(
                          btnData: btn,
                        ),
                      ))
                  .toList()),
        ]));
  }
}
