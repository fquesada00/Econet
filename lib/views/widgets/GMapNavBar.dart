import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class GMapNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool withBack;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final BuildContext context;
  const GMapNavBar({
    Key key,
    @required this.height,
    this.text, this.withBack,this.backgroundColor, this.textColor, this.context
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(left: 5,top: 60, right:5,bottom: 0),
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(5),
              child: Row(children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: backgroundColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: backgroundColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: backgroundColor),
                        ),
                        hintText: "Search",
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () => null,
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}