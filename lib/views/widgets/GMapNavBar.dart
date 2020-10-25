import 'package:econet/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GMapNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool withBack;
  final Color backgroundColor;
  final Color textColor;
  final BuildContext context;
  const GMapNavBar(
      {Key key,
      @required this.text,
      this.withBack,
      this.backgroundColor,
      this.textColor,
      this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Border radius de la search bar
    final BorderRadius _BORDER_RADIUS = BorderRadius.circular(60);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Container(
              color: Colors.transparent,
              child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: MaterialButton(
                          elevation: 5,
                          color: GREEN_MEDIUM,
                          textColor: Colors.white,
                          onPressed: () {
                            print("aösldjfsöaldjflösaj");
                            print(Scaffold.of(context).isDrawerOpen);
                            Scaffold.of(context).openDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5,
                          borderRadius: _BORDER_RADIUS,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: _BORDER_RADIUS,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: _BORDER_RADIUS,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: _BORDER_RADIUS,
                              ),
                              hintText: "Search locations, filters",
                              hintStyle: TextStyle(
                                fontFamily: 'SFProDisplay',
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: MaterialButton(
                          elevation: 5,
                          //color: (Scaffold.of(context).isDrawerOpen) ? Colors.white : BROWN_MEDIUM,
                          //textColor: (Scaffold.of(context).isDrawerOpen) ? BROWN_MEDIUM : Colors.white,
                          color : BROWN_MEDIUM,
                          textColor: Colors.white,
                          onPressed: () => null,
                          child: Icon(
                            Icons.notifications,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        ),
                      ),
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
  Size get preferredSize => Size.fromHeight(75);
}
