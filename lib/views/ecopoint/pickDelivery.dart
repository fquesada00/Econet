import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/widgets/econet_chip.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';

class PickDelivery extends StatefulWidget {
  @override
  PickDeliveryState createState() => PickDeliveryState();
}

class PickDeliveryState extends State<PickDelivery> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      backgroundColor: BROWN_DARK,
      appBar: NavBar(
        backgroundColor: BROWN_DARK,
        withBack: true,
        //textColor: GREEN_DARK,
        text: "Pick a day for delivering residues",
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        SizedBox(height: 30),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InfoCardContainer(
              content: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                    height: 200,
                    color: Color(0xFFE5E2E2),
                    alignment: Alignment.center,
                    child: Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: [Container()] /*List<Widget>.from((arguments['residues']
                          .map((residue) =>
                          EconetChip(residue, CHIP_DATA[residue], false))
                          .toList())),*/
                    )),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15),

            child: Button1(
            btnData: ButtonData(
              'CONTINUE',
                  () {},
              backgroundColor: GREEN_LIGHT,
            ),
          ),
          ),
        ),
      ]),
    );
  }
}

class EcollectorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 180,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: GREEN_DARK,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Container(
        height: 180,
        width: 170,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Ecollector',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white)),
            CircleAvatar(radius: 45, backgroundColor: Colors.white),
            Button1(
              btnData: ButtonData(
                'Beto',
                () {},
                backgroundColor: Colors.white,
                textColor: GREEN_DARK,
                fontSize: 23,
                width: 80,
                height: 35,
                fontWeight: FontWeight.w600,
                adjust: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCardContainer extends StatelessWidget {
  final Widget content;
  final String header;
  final IconData icon;

  InfoCardContainer({this.content, this.header, this.icon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const containerHeight = 70.0;

    return Container(
      width: size.width * 0.8,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              height: containerHeight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,5,10,5),
                child: content,
              ),
            ),
            Container(
              height: containerHeight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,5,10,5),
                child: content,
              ),
            ),
          ],
        )
    );
  }
}
