import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/text_above_numbered_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PendingDeliveryCard extends StatelessWidget {
  String name;
  int bags;
  String time;

  PendingDeliveryCard(this.name, this.bags, this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only( left: 10, right: 10),
              height: 80,
              child: LimitedBox(
                child:
                    SvgPicture.asset('assets/artwork/profile-default.svg'),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: GREEN_DARK,
                            fontSize: 22,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 5),
                      child: TextAboveNumberedCircle("Bags", bags, GREEN_DARK),
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            "Due in",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontFamily: 'SFProDisplay',
                            ),
                          ),
                        ),
                        Chip(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          label: Text(
                            time,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          backgroundColor: BROWN_DARK,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.chevron_right,
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
