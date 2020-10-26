import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/widgets/econet_chip.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/button_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EcopointInfo extends StatefulWidget {
  //EcopointInfo({this.adress);
  //String adress;
  @override
  State<StatefulWidget> createState() => EcopointInfoState();
}

class EcopointInfoState extends State<EcopointInfo> {
  //EcopointInfoState({this.adress});
  //String adress;
  List<String> residues = ['Paper', 'Plastic', 'Glass', 'Wood'];

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 340,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Beto",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "0.2 km",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF989898),
                          ),
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: IconButton(
                      icon: Icon(CupertinoIcons.clear_circled_solid, size: 35),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(width: 10),
                  Icon(
                    Icons.place,
                    size: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFFe5e2e2),
                      //color: Colors.grey,
                    ),
                    height: 35,
                    width: 285,
                    alignment: Alignment(0, 0),
                    child: Text(
                      "Esto es una calle real 1234",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(
                      CustomIcons.recycle,
                      size: 27,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFe5e2e2),
                        //color: Colors.grey,
                      ),
                      height: 76,
                      width: 285,
                      alignment: Alignment(0, 0),
                      child: Wrap(
                        runSpacing: 5,
                        spacing: 5,
                        alignment: WrapAlignment.center,
                        children: residues
                            .map((residue) =>
                                EconetChip(residue, CHIP_DATA[residue], false))
                            .toList(),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Button1(
                btnData: ButtonData(
                    text: 'OPEN ECOPOINT',
                    color: GREEN_MEDIUM,
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup_method');
                    }),
                width: 150,
                extend: true,
              ),
            ),
          ],
        ));
  }
}

//Creates a row for the materials such as paper or glass
Widget materialRow(text1, color1, text2, color2, text3, color3) {
  return Wrap(runSpacing: 5, alignment: WrapAlignment.center, children: [
    Container(
      padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Color(color1),
        //color: Colors.grey,
      ),
      height: 30,
      width: 80,
      alignment: Alignment(0, 0),
      child: Text(
        text1,
        style: TextStyle(color: Colors.black),
      ),
    ),
    SizedBox(width: 7),
    Container(
      padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Color(color2),
        //color: Colors.grey,
      ),
      height: 30,
      width: 80,
      alignment: Alignment(0, 0),
      child: Text(
        text2,
        style: TextStyle(color: Colors.black),
      ),
    ),
    SizedBox(width: 7),
    Container(
      padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Color(color3),
        //color: Colors.grey,
      ),
      height: 30,
      width: 80,
      alignment: Alignment(0, 0),
      child: Text(
        text3,
        style: TextStyle(color: Colors.black),
      ),
    ),
  ]);
}
