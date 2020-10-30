import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/widgets/econet_chip.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:flutter/src/widgets/framework.dart';


/*class PickDelivery extends StatefulWidget {
  @override
  PickDeliveryState createState() => PickDeliveryState();
}*/

class PickDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final List<String> arguments = ModalRoute.of(context).settings.arguments as List<String>;
    final testList = List<String>(10);
    testList[0] = "Testlist";
    testList[1] = "newThing";
    testList[2] = "Monday: 2203";
    testList[3] = "Testlist";
    testList[4] = "newThing";
    testList[5] = "Monday: 2203";
    testList[6] = "Testlist";
    testList[7] = "newThing";
    testList[8] = "Monday: 2203";
    testList[9] = "Monday: 2203";
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
              timeslots: testList //arguments,
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



class InfoCardContainer extends StatelessWidget {
  final List<String> timeslots;

  InfoCardContainer({this.timeslots});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("TIMESLOTTTTTTTTTT##################");
    print(this.timeslots);
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
        ListView(
          children: List<Widget>.from((this.timeslots
              .map((time) =>
              TimeslotCard(time, Colors.grey, true))
              .toList()))
        )
    );
  }
}
class TimeslotCard2 extends StatelessWidget{
  final String timeslot;
  TimeslotCard2(this.timeslot);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,5,10,5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child:Container(
          height: 50,
          color: Color(0xFFE5E2E2),
          alignment: Alignment.center,
          child: Text(this.timeslot),
        ),
      ),
    );
  }
}


class TimeslotCard extends StatefulWidget {
  final String chipName;
  final Color chipColor;
  final bool isFilter;

  TimeslotCard(this.chipName, this.chipColor, this.isFilter);

  @override
  TimeslotCardState createState() => TimeslotCardState();
}

class TimeslotCardState extends State<TimeslotCard> {
  bool _isSelected = false;
  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {

    return FilterChip(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        label: Text(
          widget.chipName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: textColor,
          ),
        ),
        selected: _isSelected,
        backgroundColor: widget.chipColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        pressElevation: 0,
        onSelected: (isSelected) {
          //Solo es seleccionable si es un filtro
          if (widget.isFilter) {
            setState(() {
              _isSelected = isSelected;
            });
          }
        },
        selectedColor: widget.chipName == 'Recycling Plants Only'
            ? TinyColor(widget.chipColor).brighten(50).color
            : TinyColor(widget.chipColor).brighten(15).color);
  }
}