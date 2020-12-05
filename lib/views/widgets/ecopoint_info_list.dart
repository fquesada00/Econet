import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'econet_filter_chip.dart';

class EcopointInfoList extends StatelessWidget {
  final Ecopoint ecopoint;
  final bool withoutPicture;
  final Widget button;

  EcopointInfoList(this.ecopoint, this.withoutPicture, this.button);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (withoutPicture)
          EditInformationCard(
              null,
              "assets/icons/econet-circle.svg",
              "Ecopoint name",
              Text(
                ecopoint.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'SFProDisplay',
                ),
              ),
              withoutPicture),
        if (!withoutPicture)
          Column(
            children: <Widget>[
              Container(
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
                      child: SvgPicture.asset(
                          'assets/artwork/profile-default.svg'),
                    ),
                  ),
                  Chip(
                    backgroundColor: Colors.white,
                    label: Text(
                      ecopoint.ecollector.fullName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GREEN_DARK,
                        fontSize: 20,
                        fontFamily: 'SFProDisplay',
                      ),
                    ),
                  ),
                ]),
              ),
              if (button != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: button,
                ),
            ],
          ),
        EditInformationCard(
            Icons.room,
            null,
            "Address",
            Text(
              ecopoint.address,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'SFProDisplay',
              ),
            ),
            withoutPicture),
        EditInformationCard(
            FaIcon(FontAwesomeIcons.recycle).icon,
            null,
            "Collects",
            Container(
              height: 30,
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.from(
                  CHIP_DATA.keys
                      .where((element) => ecopoint.residues
                          .contains(residueFromString(element)))
                      .map(
                        (k) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: EconetFilterChip(k, CHIP_DATA[k]),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            withoutPicture),
        EditInformationCard(
            Icons.calendar_today,
            null,
            "Delivers on",
            Text(
              ecopoint.deadline.toIso8601String().substring(0, 10),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.w600,
              ),
            ),
            withoutPicture),
        EditInformationCard(
            null,
            null,
            "Available at",
            Column(
              children: List.from(
                ecopoint.openHours
                    .map((e) => Container(
                          margin: EdgeInsets.only(top: 3, bottom: 3, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  e.toStringDay() + ": ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'SFProDisplay',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      e.toStringRanges(),
                                      maxLines: 5,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'SFProDisplay',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            withoutPicture),
        EditInformationCard(
            null,
            null,
            "Additional information",
            Text(
              ecopoint.additionalInfo,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'SFProDisplay',
              ),
            ),
            withoutPicture),
      ],
    );
  }
}

class EditInformationCard extends StatelessWidget {
  IconData icon;
  String svgUrl;
  String name;
  Widget content;
  bool editable;

  EditInformationCard(
      this.icon, this.svgUrl, this.name, this.content, this.editable);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
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
                      color: GREEN_DARK,
                      fontSize: 22,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w500,
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
                          child: Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.white,
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
