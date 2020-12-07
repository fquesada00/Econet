import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:flutter/src/widgets/framework.dart';



class PickWeekday extends StatelessWidget {
  final List<bool> isWeekdayAllowed = List();
  final createEcopointModel = CreateEcopointModel.instance;
  var numberOfDays;
  DateTime _actual = DateTime.now();
  @override


  Widget build(BuildContext context) {

    DateTime deliveryDate = createEcopointModel.deliveryDate;
    this.numberOfDays = deliveryDate.difference(_actual).inDays + 1;

    if (this.numberOfDays>6){
      this.numberOfDays = 6;
    }
    final dayList = WEEKLIST;
    List<DateTime> availableDays = List();
    print(this.numberOfDays);
    for (int i = 0; i<(this.numberOfDays+1); i++){
      int daysBack = this.numberOfDays - i;
      var currentDay = deliveryDate.subtract(new Duration(days:daysBack));
      availableDays.add(currentDay);
      this.isWeekdayAllowed.add(false);
    }
    print("availableDays");
    print(availableDays.length);

    /*dayList[(deliveryDate.weekday-daysBack+6)%6] + " "+
        currentDay.day.toString() +
        "/" +
        currentDay.month.toString()*/
    List<DateTime> getChosenWeekdays(){
      List<DateTime> chosenDays = List();
      for(int i = 0;i<this.numberOfDays+1;i++){
        if(this.isWeekdayAllowed[i]){
          chosenDays.add(availableDays[i]);
        }
      }
      return chosenDays;
    };
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
                    availableDays,
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
                          List<DateTime> chosenWeekdays = getChosenWeekdays();
                          createEcopointModel.chosenWeekdays = chosenWeekdays;
                          createEcopointModel.timeslotsWeekdays = List.filled(chosenWeekdays.length, null, growable: false);
                          Navigator.pushNamed(context, '/pickTimeCreateEcopoint',
                          arguments: {
                            //"currentDay": this.isWeekdayAllowed.indexWhere((selected) => selected == true),
                            "currentDay": 0,
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

  final List<DateTime> timeslots;
  final List<bool> pickWeekday;

  TimeslotCard(this.timeslots, this.pickWeekday);

  @override
  TimeslotCardState createState() => TimeslotCardState(this.timeslots, this.pickWeekday);
}

class TimeslotCardState extends State<TimeslotCard> {

  final List<DateTime> timeslots;
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
                    WEEKLIST[this.timeslots[index].weekday-1],
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