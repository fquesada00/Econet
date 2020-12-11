import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/tutorials/tutorial_picked.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/tab_slide_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';


class Tutorials extends StatelessWidget {
  @override
  _buildChoiceList(context) {
    List<Widget> choices = List();
    RESIDUES.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(10.0),
        child: ChoiceChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          pressElevation: 0,
          label: Container(
            width: 250,
            height:50,
            alignment: Alignment.center,
            child: Text(
              item,
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'SFProDisplay',
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: CHIP_DATA[item],
          selectedColor:
          TinyColor(CHIP_DATA[item]).brighten(20).color,
          selected: false,
          onSelected: (selected) {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TutorialPicked(residue: residueFromString(item))),
          );})
        ),
      );}
    );
    return choices;
  }
  Widget build(BuildContext context) {
    List list = _buildChoiceList(context);

    return Container(
      color: Colors.white,
      child: Column(children: [
          NavBar(
            text: "Tutorials",
            withDrawer: true,
            backgroundColor: Colors.white,
            textColor: GREEN_DARK,
        ),
        ListView.builder(
          padding: EdgeInsets.fromLTRB(0,50,0,0),
          itemBuilder: (context, idx) {
          return list[idx];
            },
              itemCount: list.length,
              shrinkWrap: true,
            )
      ])
    );
  }
}
