import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EconetButton extends StatelessWidget {
  EconetButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 33,
            width: 33,
            child: Image.asset(
              'assets/icons/econet-circle-logo-white.png',
            ),
          ),
          Text("RECYCLE",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'SFProDisplay'),
              softWrap: false),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Color(0xFFA3CB8F),
      onPressed: onPressed,
    );
  }
}