import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextAboveNumberedCircle extends StatelessWidget {
  Color circleColor;
  int value;
  String text;

  TextAboveNumberedCircle(this.text, this.value, this.circleColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: 'SFProDisplay',
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 33,
            width: 33,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor,
            ),
            child: Text(
              value.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
