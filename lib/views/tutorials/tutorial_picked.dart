import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/InformationCard.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/tab_slide_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';


class TutorialPicked extends StatelessWidget {
  Residue residue;

  TutorialPicked({this.residue});

  @override

  Widget build(BuildContext context) {
    List list = [
      "How to prepare " + residueToString(this.residue).toLowerCase() + " for recycling",
      "How to prepare **Other thing** for recycling",
      "Which types of " + residueToString(this.residue).toLowerCase() +  " are safe for recycling"
    ];

    return Container(
      color: Colors.white,
      child: Column(children: [
          NavBar(
            text: residueToString(this.residue) + " Tutorials",
            withBack: true,
            backgroundColor: Colors.white,
            textColor: GREEN_DARK,
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: 800,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: GREEN_MEDIUM,
          ),
          child: Column(
          children: List.generate(list.length, (index) {
            return Container(
              height: 100,
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 36,),
                  Container(width: 250,child:
                  Center(
                    child:Text(
                      list[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GREEN_DARK,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )
                    )
                  )),
                  Icon(
                    Icons.chevron_right,
                    size: 36,
                  )
              ],)
            );
          })
          )
        )
      ])
    );
  }
}
