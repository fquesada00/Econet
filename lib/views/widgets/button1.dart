import 'package:econet/views/widgets/button_data.dart';
import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final ButtonData btnData;
  //Constructor
  Button1({this.btnData});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
        height: size.height / 13,
        minWidth: size.width * 0.75,
        color: btnData.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(104),
        ),
        elevation: 0,
        highlightElevation: 0,
        highlightColor: btnData.color,
        splashColor: Colors.white.withOpacity(0.4),
        textColor: Colors.white,
        onPressed: btnData.onPressed,
        child: Container(
          width: size.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (btnData.icon != null) (btnData.icon),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  btnData.text,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
