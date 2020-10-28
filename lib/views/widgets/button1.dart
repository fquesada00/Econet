import 'package:econet/views/widgets/button_data.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Button1 extends StatefulWidget {
  final ButtonData btnData;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final bool adjust;
  //Constructor
  Button1({
    this.btnData,
    this.width = 0,
    this.height = 0,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w500,
    this.adjust = false,
  });

  @override
  _Button1State createState() =>
      _Button1State(btnData, width, height, fontSize, fontWeight, adjust);
}

class _Button1State extends State<Button1> {
  double width;
  double height;
  double fontSize;
  FontWeight fontWeight;
  double minWidth;
  ButtonData data;
  //Propiedad para hacer que el boton se ajuste al width
  bool adjust;

  _Button1State(this.data, this.width, this.height, this.fontSize,
      this.fontWeight, this.adjust);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (width == null || width == 0) {
      width = size.width * 0.7;
    }

    if (height == null || height == 0) {
      height = size.height / 13;
    }

    if (adjust) {
      minWidth = width;
    } else {
      minWidth = size.width * 0.87;
    }

    return MaterialButton(
        height: height,
        minWidth: minWidth,
        color: widget.btnData.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(104),
        ),
        elevation: 0,
        highlightElevation: 0,
        highlightColor: widget.btnData.backgroundColor,
        splashColor: Colors.white.withOpacity(0.4),
        textColor: widget.btnData.textColor,
        onPressed: widget.btnData.onPressed,
        child: Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.btnData.icon != null)
                Expanded(flex: 1, child: (widget.btnData.icon)),
              Expanded(
                flex: 6,
                child: AutoSizeText(
                  widget.btnData.text,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: fontWeight,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
