import 'package:econet/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EcollectorInfo extends StatelessWidget {
  final String name;
  final Color backgroundColor;

  EcollectorInfo(this.name, this.backgroundColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: backgroundColor,
      ),
      child: Column(children: <Widget>[
        Text(
          "ECOLLECTOR",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: GREEN_LIGHT,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: LimitedBox(
            child: SvgPicture.asset('assets/artwork/profile-default.svg'),
          ),
        ),
        Text(
          name != null ? name : '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        )
      ]),
    );
  }
}
