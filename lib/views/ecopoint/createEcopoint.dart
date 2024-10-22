import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/econet_display_chip.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/open_hours_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEcopoint extends StatelessWidget {
  //Set the ecopoint to NULL when user clicks shedule trip!!!! Then everything else should work fine
  ScrollController _controller1 = new ScrollController();
  ScrollController _controller2 = new ScrollController();
  final createEcopointModel = CreateEcopointModel.instance;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    Ecopoint plant = arguments['plant'];

    return Scaffold(
      backgroundColor: GREEN_LIGHT,
      appBar: NavBar(
        backgroundColor: GREEN_LIGHT,
        withBack: true,
        textColor: GREEN_DARK,
        text: (plant.name != null) ? plant.name : "NULL",
      ),
      body: ListView(children: <Widget>[
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'CreateButton',
              child: Button1(
                btnData: ButtonData(
                  'CREATE ECOPOINT',
                  () {
                    createEcopointModel.reset();
                    createEcopointModel.plant = plant;
                    Navigator.pushNamed(context, '/pickDeliveryMaterials');
                  },
                  backgroundColor: GREEN_DARK,
                  fontSize: 24,
                  svgUrl: 'assets/icons/econet-circle.svg',
                  adjust: true,
                  width: 230,
                  height: 50,
                ),
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
                  plant.address,
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
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      height: 70,
                      color: Color(0xFFE5E2E2),
                      alignment: Alignment(0, 0),
                      child: SingleChildScrollView(
                          controller: _controller1,
                          child: Wrap(
                            runSpacing: -7,
                            spacing: 5,
                            alignment: WrapAlignment.center,
                            children: List<Widget>.from(plant.residues
                                .map((residue) => EconetDisplayChip(
                                    residueToString(residue),
                                    CHIP_DATA[residueToString(residue)]))
                                .toList()),
                          )))),
            ),
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InfoCardContainer(
            header: 'Open hours',
            icon: CupertinoIcons.clock,
            content: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                color: Color(0xFFE5E2E2),
                alignment: Alignment(0, 0),
                child: OpenHoursList(
                  timeSlots: plant.openHours,
                ),
              ),
            ),
          ),
        ),
      ]),
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
