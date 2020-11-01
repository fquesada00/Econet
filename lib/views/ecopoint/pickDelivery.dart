import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:econet/presentation/constants.dart';


/*class PickDelivery extends StatefulWidget {
  @override
  PickDeliveryState createState() => PickDeliveryState();
}*/

class PickDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final List<String> arguments = ModalRoute.of(context).settings.arguments as List<String>;
    final testList = List<String>(10);
    testList[0] = "Mon 26/10 15:30-17:30";
    testList[1] = "Mon 26/10 19:30-21:00";
    testList[2] = "Tue 27/10 17:00-19:00";
    testList[3] = "Wed 28/10 17:00-19:00";
    testList[4] = "Thu 29/10 10:00-12:00";
    testList[5] = "Wen 26/10 15:30-17:30";
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
            child: TimeslotCard(
              testList //arguments,
            ),
          ),
        ),
        Center(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 40),

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


/*
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
*/

class TimeslotCard extends StatefulWidget {

  final List<String> timeslots;

  TimeslotCard(this.timeslots);

  @override
  TimeslotCardState createState() => TimeslotCardState(this.timeslots);
}

class TimeslotCardState extends State<TimeslotCard> {

  final List<String> timeslots;
  //bool _isSelected = false;
  //Color textColor = Colors.white;
  TimeslotCardState(this.timeslots);
  int _value = 1;
  final String _ecollector = 'Beto';



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.8,
        height: 430,
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
            Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
              Container(height: 330,child:
              ListView(
              children: List<Widget>.generate(this.timeslots.length,
                  (int index) {
                      return Column(children:[SizedBox(height: 10,),
                      ChoiceChip(
                          label: Container(
                            width: 240,
                            height: 40,
                            child:
                              Center(child: Text(
                              this.timeslots[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              )
                          ),

                          backgroundColor: Color(0xFFE5E2E2),
                          selectedColor: Color(0xFFBCBCBC),
                          selectedShadowColor: Colors.black,
                          selected: _value == index,
                          materialTapTargetSize: MaterialTapTargetSize.values[1],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          pressElevation: 0,
                          onSelected: (bool selected) {
                            setState(() {
                              //_value = selected ? index : null;
                              _value = selected ? index : null;
                            });

                          },
                          )
                      ]
                      );

              }
              ).toList()
              )
              ),
              Container(
                width: 260,
                height: 50,
                  decoration: BoxDecoration(
                    color: BROWN_DARK,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    /*boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        //blurRadius: 6,
                        //offset: Offset(0, 3),
                      )
                    ],*/
                  ),
                child:
                  Center(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                  "Arrange personally with $_ecollector",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  ),
                  )
                  )
              ),
                  SizedBox(height: 0)
              ]
            )
    );
  }
}
