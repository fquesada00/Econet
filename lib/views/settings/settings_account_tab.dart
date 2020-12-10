import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//widget auxiliar
class SettingDetails extends StatelessWidget {
  String name; //deberia estar la funcion que te lleve a donde sea pertinente

  SettingDetails(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.infinity,
      height: 56,
      color: Colors.grey.withOpacity(0.5),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(
              name,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'SFProText',
                color: Colors.black,
              ),
            ),
          ),
          Spacer(),
          Icon(
            Icons.chevron_right,
            size: 36,
          ),
        ],
      ),
    );
  }
}

class SettingsAccountTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 26, top: 26),
            child: Text(
              "Avatar",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'SFProDisplay',
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 125,
          color: Colors.grey.withOpacity(0.5),
          child: LimitedBox(
            child: SvgPicture.asset('assets/artwork/profile-default.svg'),
          ),
        ),
        SettingDetails("Upload new image"),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 26, top: 40),
            child: Text(
              "Details",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'SFProDisplay',
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SettingDetails("Edit full name"),
        SettingDetails("Edit phone number"),
      ],
    );
  }
}
