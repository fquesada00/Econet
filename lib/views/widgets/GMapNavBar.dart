import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:econet/views/widgets/drawer.dart';


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
  //GMapNavBar({this.text, this.withBack,this.backgroundColor, this.textColor, this.height,this.context});

 /*@override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: backgroundColor,
        height: height,
        width: size.width,
        child: SafeArea(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (withBack)
                  Expanded(
                    child: Align(
                      alignment: Alignment(-0.7, 1),
                      child: CupertinoButton(
                        child: Icon(
                          CupertinoIcons.list_bullet,
                          color: Colors.black,
                        ),
                          onPressed: () {
                            print("######HELLO FROM DRAWER########");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AppDrawer()),
                            );
                          },
                          ),
                    ),
                  )
                else
                  (Spacer()),
                Expanded(
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
              ]),
        ));
  }
*/
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: AppBar(
              title: Container(
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.verified_user),
                  onPressed: () => null,
                ),
              ],
            ) ,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}