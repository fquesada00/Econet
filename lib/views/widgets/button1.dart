import 'package:econet/views/widgets/button_data.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Button1 extends StatefulWidget {
  final ButtonData btnData;
  final double width;
  final bool extend;
  //Constructor
  Button1({this.btnData, this.width = 0, this.extend = false});

  @override
  _Button1State createState() => _Button1State(btnData, width, extend);
}

class _Button1State extends State<Button1> {
  double width;
  double minWidth;
  ButtonData data;
  bool extend;

  _Button1State(ButtonData data, double width, bool extend) {
    this.data = data;
    this.width = width;
    this.extend = extend;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(width);
    if (width == null || width == 0) {
      width = size.width * 0.7;
    }

    if (extend) {
      minWidth = size.width * 0.87;
    } else {
      minWidth = size.width * 0.75;
    }

    print(minWidth);

    return MaterialButton(
        height: size.height / 13,
        minWidth: minWidth,
        color: widget.btnData.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(104),
        ),
        elevation: 0,
        highlightElevation: 0,
        highlightColor: widget.btnData.color,
        splashColor: Colors.white.withOpacity(0.4),
        textColor: Colors.white,
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
