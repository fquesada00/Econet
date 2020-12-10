import 'package:econet/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InformationCard extends StatelessWidget {
  IconData icon;
  String svgUrl;
  String name;
  Color nameColor;
  Widget content;
  bool editable;
  Function edit;

  InformationCard(
      {this.icon,
      this.svgUrl,
      this.name,
      this.nameColor,
      this.content,
      this.editable = false,
      this.edit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
      padding: EdgeInsets.only(top: 5, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: <Widget>[
                Spacer(),
                Expanded(
                  flex: 4,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: nameColor,
                      fontSize: 24,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: (!editable)
                      ? Container()
                      : Container(
                          alignment: Alignment.center,
                          height: 33,
                          width: 33,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: GestureDetector(
                            onTap: edit,
                            child: Icon(
                              Icons.edit,
                              size: 26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: Row(
              children: <Widget>[
                if (icon != null)
                  Expanded(
                    flex: 1,
                    child: Icon(
                      icon,
                      size: 30,
                    ),
                  ),
                if (svgUrl != null)
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      svgUrl,
                      height: 30,
                      color: Colors.black,
                    ),
                  ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(10), child: content),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
