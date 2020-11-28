import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/widgets/econet_chip.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';

class EcopointExpanded extends StatelessWidget {
  ScrollController _controller1 = new ScrollController();
  ScrollController _controller2 = new ScrollController();


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      backgroundColor: GREEN_LIGHT,
      appBar: NavBar(
        backgroundColor: GREEN_LIGHT,
        withBack: true,
        textColor: GREEN_DARK,
        text: arguments['ecopointName'],
      ),
      body: ListView(children: <Widget>[
        SizedBox(height: 30),
        Center(
          child: EcollectorCard(),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button1(
              btnData: ButtonData(
                'RECYCLE',
                () {
                  Navigator.pushNamed(context, '/pickDelivery', arguments: {
                    'ecopointName': "ecopointName",
                    'address': "address",
                    'distance': "distance",
                    'residues': "residues",
                    'ecollector': "ecollector",
                    'deliveryDate': "deliveryDate",
                  });
                },
                backgroundColor: GREEN_DARK,
                fontSize: 24,
                svgUrl: 'assets/icons/econet-circle.svg',
                adjust: true,
                width: 200,
                height: 50,
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InfoCardContainer(
            header: 'Address',
            icon: Icons.place,
            content: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 50,
                color: Color(0xFFE5E2E2),
                alignment: Alignment.center,
                child: Text(
                  arguments['address'],
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InfoCardContainer(
            header: 'Collects',
            icon: CustomIcons.recycle,
            content: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CupertinoScrollbar(
                  isAlwaysShown: true,
                  controller: _controller1,
                  child: Container(
                      height: 70,
                      color: Color(0xFFE5E2E2),
                      alignment: Alignment(0, 0),
                      child: SingleChildScrollView(controller: _controller1,child: Wrap(

                        runSpacing: 5,
                        spacing: 5,
                        alignment: WrapAlignment.center,
                        children: List<Widget>.from((arguments['residues']
                            .map((residue) =>
                            EconetChip(residue, CHIP_DATA[residue], false))
                            .toList())),
                      ))
                  )),
            ),
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InfoCardContainer(
            header: 'Delivers on',
            icon: CupertinoIcons.car,
            content: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CupertinoScrollbar(
                  isAlwaysShown: true,
                  controller: _controller2,
                  child: Container(
                  height: 70,
                  color: Color(0xFFE5E2E2),
                  alignment: Alignment(0, 0),
                  child: SingleChildScrollView(controller: _controller2,child: Wrap(

                    runSpacing: 5,
                    spacing: 5,
                    alignment: WrapAlignment.center,
                    children: List<Widget>.from((arguments['residues']
                        .map((residue) =>
                            EconetChip(residue, CHIP_DATA[residue], false))
                        .toList())),
                  ))
              )),
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

    return Container(
      width: size.width * 0.8,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              header,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: GREEN_DARK,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (icon != null)
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      bottom: 20,
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                    ),
                  ),
                ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 20),
                  child: content,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
