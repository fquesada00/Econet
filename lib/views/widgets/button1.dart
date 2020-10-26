import 'package:econet/views/widgets/button_data.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
              if (btnData.icon != null) Expanded(flex: 1, child: (btnData.icon)),
              Expanded(
                flex: 6,
                child: AutoSizeText(
                  btnData.text,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
