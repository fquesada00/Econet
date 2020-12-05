import 'package:econet/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EcollectorInfo extends StatelessWidget {
  final String name;

  EcollectorInfo(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: GREEN_DARK,
      ),
      child: Column(children: <Widget>[
        Text(
          "Ecollector",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'SFProDisplay',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: LimitedBox(
            child: SvgPicture.asset('assets/artwork/profile-default.svg'),
          ),
        ),
        Chip(
          backgroundColor: Colors.white,
          label: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: GREEN_DARK,
              fontSize: 20,
              fontFamily: 'SFProDisplay',
            ),
          ),
        ),
      ]),
    );
  }
}
