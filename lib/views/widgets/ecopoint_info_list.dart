import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/ecollector_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'InformationCard.dart';
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
          InformationCard(
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
              EcollectorInfo(ecopoint.ecollector.fullName),
              if (button != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: button,
                ),
            ],
          ),
        InformationCard(
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
        InformationCard(
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
        InformationCard(
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
        InformationCard(
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
        InformationCard(
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
