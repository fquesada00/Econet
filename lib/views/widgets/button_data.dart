import 'package:econet/presentation/constants.dart';
import 'package:flutter/material.dart';

class ButtonData {
  String text;
  Icon icon;
  Color textColor;
  Color backgroundColor;
  Function onPressed;

  ButtonData(this.text,
      {this.icon,
      this.onPressed,
      this.textColor = Colors.white,
      this.backgroundColor = GREEN_MEDIUM});
}
