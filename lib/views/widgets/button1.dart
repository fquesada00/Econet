import 'package:flutter/material.dart';
import 'package:econet/constants.dart';

class Button1 extends StatelessWidget {

  final String text;
  final Function onPressed;
  final Color color;

  //Constructor
  Button1({this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
        height: size.height/13,
        minWidth: size.width * 0.75,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(104),
        ),
        elevation: 0,
        highlightElevation: 0,
        highlightColor: color,
        splashColor: Colors.white.withOpacity(0.4),
        textColor: Colors.white,
        onPressed: onPressed,

        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'SFProDisplay',
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}
