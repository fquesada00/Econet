import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/ecollector_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'InformationCard.dart';
import 'econet_display_chip.dart';
import 'econet_filter_chip.dart';

class EcopointInfoList extends StatefulWidget {
  final Ecopoint ecopoint;
  final bool withoutPicture;
  final Widget button;

  EcopointInfoList(this.ecopoint, this.withoutPicture, this.button);

  @override
  _EcopointInfoListState createState() => _EcopointInfoListState();
}

class _EcopointInfoListState extends State<EcopointInfoList> {
  TextEditingController name_controller = new TextEditingController();
  FocusNode name_focus_node = FocusNode();
  TextEditingController additional_info_controller =
      new TextEditingController();
  FocusNode additional_info_focus_node = FocusNode();

  @override
  void dispose() {
    name_focus_node.dispose();
    additional_info_focus_node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    name_controller.text = widget.ecopoint.name;
    additional_info_controller.text = widget.ecopoint.additionalInfo;
    return Column(
      children: <Widget>[
        if (widget.withoutPicture)
          InformationCard(
            svgUrl: "assets/icons/econet-circle.svg",
            name: "Ecopoint name",
            nameColor: GREEN_DARK,
            content: Container(
              height: 28,
              child: TextField(
                maxLength: 20,
                controller: name_controller,
                focusNode: name_focus_node,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'SFProDisplay',
                ),
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    counterStyle: TextStyle(
                      height: double.minPositive,
                    ),
                    counterText: ""),
              ),
            ),
            editable: widget.withoutPicture,
            edit: () {
              name_focus_node.requestFocus();
            },
          ),
        if (!widget.withoutPicture)
          Column(
            children: <Widget>[
              EcollectorInfo(widget.ecopoint.ecollector.fullName, GREEN_DARK),
              if (widget.button != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: widget.button,
                ),
            ],
          ),
        InformationCard(
          icon: Icons.room,
          name: "Address",
          nameColor: GREEN_DARK,
          content: Text(
            widget.ecopoint.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'SFProDisplay',
            ),
          ),
          editable: widget.withoutPicture,
          edit: () {
            Navigator.pushNamed(context, '/pickLocation',
                arguments: widget.ecopoint);
          },
        ),
        InformationCard(
          icon: FaIcon(FontAwesomeIcons.recycle).icon,
          name: "Collects",
          nameColor: GREEN_DARK,
          content: Container(
            height: 30,
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: List.from(
                CHIP_DATA.keys
                    .where((element) => widget.ecopoint.residues
                        .contains(residueFromString(element)))
                    .map(
                      (k) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: EconetDisplayChip(k, CHIP_DATA[k]),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          editable: widget.withoutPicture,
          edit: () {
            Navigator.pushNamed(context, '/pickDeliveryMaterials',
                arguments: widget.ecopoint);
          },
        ),
        InformationCard(
          icon: Icons.calendar_today,
          name: "Delivers on",
          nameColor: GREEN_DARK,
          content: Text(
            widget.ecopoint.deadline.toIso8601String().substring(0, 10),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w600,
            ),
          ),
          editable: widget.withoutPicture,
          edit: () {
            Navigator.pushNamed(context, '/pickDeliveryDate',
                arguments: widget.ecopoint);
          },
        ),
        InformationCard(
            name: "Available at",
            nameColor: GREEN_DARK,
            content: Column(
              children: List.from(
                widget.ecopoint.openHours
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
            editable: widget.withoutPicture),
        InformationCard(
          name: "Additional information",
          nameColor: GREEN_DARK,
          content: TextField(
            controller: additional_info_controller,
            focusNode: additional_info_focus_node,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'SFProDisplay',
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          ),
          editable: widget.withoutPicture,
          edit: () {
            additional_info_focus_node.requestFocus();
          },
        ),
      ],
    );
  }
}
