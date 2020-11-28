import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:flutter/src/widgets/framework.dart';



class PickWeekday extends StatelessWidget {
  final List<bool> isWeekdayAllowed = List.filled(7, false, growable: false);
  final createEcopointModel = CreateEcopointModel.instance;

  @override
  Widget build(BuildContext context) {
    //final List<String> arguments = ModalRoute.of(context).settings.arguments as List<String>;

    final dayList = WEEKLIST;

    return Scaffold(
      backgroundColor: BROWN_DARK,
      appBar: NavBar(
        backgroundColor: BROWN_DARK,
        withBack: true,
        //textColor: GREEN_DARK,
        text: "Choose the days you are available",
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TimeslotCard(
                    dayList,
                    this.isWeekdayAllowed,//arguments,
                ),
              ),
            ),
            Center(
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 40),

                child: Button1(
                  btnData: ButtonData(
                    'CONTINUE',
                        () {
                          createEcopointModel.availableWeekdays = this.isWeekdayAllowed;
                          Navigator.pushNamed(context, '/pickTimeCreateEcopoint',
                          arguments: {
                            "currentDay": this.isWeekdayAllowed.indexWhere((selected) => selected == true),
                            "daysAvailable": this.isWeekdayAllowed

                        });},
                    backgroundColor: BROWN_MEDIUM,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}


class TimeslotCard extends StatefulWidget {

  final List<String> timeslots;
  final List<bool> pickWeekday;

  TimeslotCard(this.timeslots, this.pickWeekday);

  @override
  TimeslotCardState createState() => TimeslotCardState(this.timeslots, this.pickWeekday);
}

class TimeslotCardState extends State<TimeslotCard> {

  final List<String> timeslots;
  final List<bool> pickWeekday;


  TimeslotCardState(this.timeslots, this.pickWeekday);


  @override
  Widget build(BuildContext context) {
    print(this.pickWeekday);
    print("isweek");
    //print(this.pickWeekday.isWeekdayAllowed);
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.8,
        height: 420,
        alignment: Alignment.center,
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
        child: ListView(
        children: List<Widget>.generate(this.timeslots.length, (int index) {
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
              selected: this.pickWeekday[index],
              materialTapTargetSize: MaterialTapTargetSize.values[1],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              pressElevation: 0,
              onSelected: (bool selected) {
                setState(() {
                  //_value = selected ? index : null;
                  print(selected);
                  this.pickWeekday[index] = !this.pickWeekday[index];
                });
              },
            )
          ]
          );
        }
        ).toList()
      )
    );
  }
}