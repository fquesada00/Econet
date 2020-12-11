import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/ecollector_info.dart';
import 'package:econet/views/widgets/open_hours_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'InformationCard.dart';
import 'econet_display_chip.dart';

class EcopointInfoList extends StatefulWidget {
  final Ecopoint ecopoint;
  final bool withoutPicture;
  final Widget button;
  final TextEditingController nameController;
  final TextEditingController additionalInfoController;

  EcopointInfoList(this.ecopoint, this.withoutPicture, this.button,
      this.nameController, this.additionalInfoController);

  @override
  _EcopointInfoListState createState() => _EcopointInfoListState();
}

class _EcopointInfoListState extends State<EcopointInfoList> {
  FocusNode nameFocusNode = FocusNode();
  FocusNode additionalInfoFocusNode = FocusNode();

  @override
  void dispose() {
    nameFocusNode.dispose();
    additionalInfoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.nameController.text = widget.ecopoint.name;
    widget.additionalInfoController.text = widget.ecopoint.additionalInfo;
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
                controller: widget.nameController,
                focusNode: nameFocusNode,
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
              nameFocusNode.requestFocus();
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
            _editChoices(context);
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
          name: "Available on",
          nameColor: GREEN_DARK,
          content: OpenHoursList(
            timeSlots: widget.ecopoint.openHours,
          ),
          editable: widget.withoutPicture,
          edit: () {},
        ),
        InformationCard(
          name: "Additional information",
          nameColor: GREEN_DARK,
          content: TextField(
            controller: widget.additionalInfoController,
            focusNode: additionalInfoFocusNode,
            maxLines: 5,
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
            additionalInfoFocusNode.requestFocus();
          },
        ),
      ],
    );
  }

  _editChoices(BuildContext context) async {
    final newChoices = await Navigator.pushNamed(
        context, '/pickDeliveryMaterials',
        arguments: widget.ecopoint);

    widget.ecopoint.residues = newChoices;
    setState(() {});
  }

// _editTimeslot(BuildContext context) async {
//
//   setState(() {});
// }
}
