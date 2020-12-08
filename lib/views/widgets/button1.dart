import 'package:flutter/material.dart';
import 'package:econet/presentation/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonData {
  String text;

  //El boton acepta tantos iconos como svg, pero no ambos al mismo tiempo
  //Si se le llega a pasar los 2 campos, se le asigna solo el icono
  Icon icon;
  String svgUrl;
  Color textColor;
  Color backgroundColor;
  Function onPressed;
  double width;
  double height;
  double fontSize;
  FontWeight fontWeight;

  //Propiedad para hacer que el boton se ajuste al width
  bool adjust;
  bool enabled;

  ButtonData(
    this.text,
    this.onPressed, {
    this.icon,
    this.svgUrl,
    this.textColor = Colors.white,
    this.backgroundColor = GREEN_MEDIUM,
    this.width = 0,
    this.height = 0,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w500,
    this.adjust = false,
    this.enabled = true,
  });
}

class Button1 extends StatefulWidget {
  ButtonData btnData;

  //Constructor
  Button1({this.btnData});

  @override
  _Button1State createState() => _Button1State(btnData);
}

class _Button1State extends State<Button1> {
  double minWidth;
  ButtonData data;

  _Button1State(ButtonData data) {
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (data.width == null || data.width == 0) {
      data.width = size.width * 0.7;
    }

    if (data.height == null || data.height == 0) {
      data.height = size.height / 13;
    }

    if (data.adjust) {
      minWidth = data.width;
    } else {
      minWidth = size.width * 0.87;
    }

    if (data.svgUrl != null && data.icon != null) {
      data.svgUrl = null;
    }

    return MaterialButton(
        height: data.height,
        minWidth: minWidth,
        color: data.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(104),
        ),
        elevation: 0,
        highlightElevation: 0,
        highlightColor: data.backgroundColor,
        splashColor: Colors.white.withOpacity(0.4),
        textColor: data.textColor,
        onPressed: data.enabled
            ? data.onPressed
            : () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Center(
                    heightFactor: 1,
                    child: Text(
                      'Please select a value',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ));
              },
        child: Container(
          width: data.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: SizedBox(
                height: 0,
              )),
              if (data.icon != null) Expanded(flex: 1, child: (data.icon)),
              if (data.svgUrl != null)
                SvgPicture.asset(
                  data.svgUrl,
                  height: data.fontSize,
                ),
              Expanded(
                flex: 8,
                child: AutoSizeText(
                  data.text,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: data.fontWeight,
                    fontSize: data.fontSize,
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: 0,
              )),
            ],
          ),
        ));
  }
}
