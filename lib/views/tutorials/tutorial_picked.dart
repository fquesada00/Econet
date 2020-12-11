import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/InformationCard.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/tab_slide_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:url_launcher/url_launcher.dart';


class TutorialPicked extends StatelessWidget {
  Residue residue;

  TutorialPicked({this.residue});

  @override
  Widget build(BuildContext context) {
    List texts = [
      "How to recycle " +
          residueToString(this.residue).toLowerCase() +
          " waste",
      "Know your ${residueToString(this.residue).toLowerCase()}",
      "Which types of " +
          residueToString(this.residue).toLowerCase() +
          " are safe for recycling"
    ];
    List links = [
      "https://www.youtube.com/watch?v=jgwH2BuHCr0",
      "https://www.youtube.com/watch?v=_qTelxi3MjU",
      "https://www.youtube.com/watch?v=eymigN8tMoY"
    ];


    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(children: [
            NavBar(
              text: residueToString(this.residue) + " Tutorials",
              withBack: true,
              backgroundColor: Colors.white,
              textColor: GREEN_DARK,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: GREEN_MEDIUM,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(texts.length, (index) {
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
                              SizedBox(
                                width: 36,
                              ),
                              Container(
                                  width: 250,
                                  child: Center(
                                      child: Text(texts[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: GREEN_DARK,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          )))),
                              IconButton(
                                icon: Icon(Icons.chevron_right),
                                iconSize: 36,
                                onPressed: (){_launchURL(links[index]);print("pressed");}
                              )
                            ],
                          ));
                    })),
                  )),
            )
          ])),
    );
  }
}
_launchURL(inputURL) async {
  String url = inputURL;
  print("in launch url");
  if (await canLaunch(url)) {
    print("Launch url");
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}