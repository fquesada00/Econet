import 'package:flutter/material.dart';

class ButtonData {
  String text;
  Icon icon;
  Color color;
  Function onPressed;

  ButtonData({this.text, this.icon, this.onPressed, this.color});
}
