import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool withBack;
  final bool withDrawer;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final IconData rightIcon;
  final Function onPressedRightIcon;

  NavBar(
      {this.text,
      this.withBack = false,
      this.withDrawer = false,
      this.backgroundColor,
      this.textColor,
      this.height = 120,
      this.rightIcon,
      this.onPressedRightIcon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: backgroundColor,
      height: height,
      width: size.width,
      padding: EdgeInsets.only(top: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (withBack)
            CupertinoNavigationBarBackButton(
              color: Colors.black,
            )
          else if (withDrawer)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print(Scaffold.of(context).isDrawerOpen);
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  size: 36,
                ),
              ),
            )
          else
            Spacer(),
          Expanded(
            flex: 4,
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
          if (rightIcon != null)
            Expanded(
              child: GestureDetector(
                onTap: onPressedRightIcon,
                child: Icon(
                  rightIcon,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            )
          else
            Spacer(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
