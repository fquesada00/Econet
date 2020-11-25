import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool withBack;
  final Color backgroundColor;
  final Color textColor;
  final double height;

  NavBar(
      {this.text,
      this.withBack,
      this.backgroundColor,
      this.textColor,
      this.height = 120});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: backgroundColor,
        height: height,
        width: size.width,
        child:
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
          if (withBack)
            Expanded(
              child: Align(
                alignment: Alignment(1, 1),
                child: CupertinoNavigationBarBackButton(
                  color: Colors.black,
                ),
              ),
            )
          else
            (Spacer()),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Spacer(),
        ]));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
