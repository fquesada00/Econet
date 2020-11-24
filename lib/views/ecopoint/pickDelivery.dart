import 'dart:collection';

import 'package:econet/presentation/constants.dart';
import 'package:econet/views/timeSlot/TimeSlot.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:flutter/src/widgets/framework.dart';

class PickDelivery extends StatelessWidget {
  String getMonth(int number) {
    switch (number) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return null; //no deberia llegar
    }
  }

  String getWeekDay(int number) {
    switch (number) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return null; //no deberia llegar
    }
  }

  List<bool> unavailableWeekDays(List<TimeSlot> list) {
    List<bool> ret = List(7);
    for (int i = 0; i < ret.length; i++) ret[i] = false;
    for (int i = 0; i < list.length; i++) ret[list[i].getDay() - 1] = true;
    return ret;
  }

  // recibo el arreglo de timeslot ordenado
  DateTime firstFit(
      DateTime date, List<TimeSlot> list, DateTime start, DateTime end) {
    if (date.isAfter(start) && date.isBefore(end)) {
      DateTime ret;
      DateTime aux;
      Map<int, TimeSlot> maping = HashMap();
      for (int i = 0; i < list.length; i++)
        maping[list[i].getDay() - 1] = list[i];
      for (int i = date.weekday, j = 0; j < 7; j++) {
        if (maping.containsKey(i)) {
          for (int k = 0; k < maping[i].ranges.length; k++) {
            //EN PROCESO
            // if (ret == null) {
            //   ret = DateTime(
            //       date.year,
            //       date.month,
            //       i,
            //       maping[i].ranges[k].getFirst().hour,
            //       maping[i].ranges[k].getFirst().minute);
            //   aux = DateTime(
            //       date.year,
            //       date.month,
            //       i,
            //       maping[i].ranges[k].getLast().hour,
            //       maping[i].ranges[k].getLast().minute);
            // } else if ((ret.weekday == maping[i].getDay() &&
            //     ((aux.hour * 100 + aux.minute) <
            //         (date.hour * 100 + date.minute)) || ())) {
            //   ret = DateTime(
            //       date.year,
            //       date.month,
            //       i,
            //       maping[i].ranges[k].getFirst().hour,
            //       maping[i].ranges[k].getFirst().minute);
            //   aux = DateTime(
            //       date.year,
            //       date.month,
            //       i,
            //       maping[i].ranges[k].getLast().hour,
            //       maping[i].ranges[k].getLast().minute);
            // }

            // if((date.is) /*|| ret.isAfter(date)*/)
          }
        }
      }
    }

    return null;
  }

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

    TimeSlot t1 = TimeSlot(1);
    TimeSlot t2 = TimeSlot(2);

    t1.addRange('15:00', '20:00');
    t1.addRange('20:00', '23:59');

    t2.addRange('10:00', '20:00');

    DateTime _date;

    DateTime startCollect = DateTime(2020, 2, 13);
    DateTime endCollect = DateTime(2021, 2, 13);

    DateTime start;
    DateTime end;

    List<TimeSlot> timesSlot = List();
    timesSlot.add(t1);
    timesSlot.add(t2);

    List<bool> notAvailableWeekDays = unavailableWeekDays(timesSlot);

    return Scaffold(
      backgroundColor: BROWN_DARK,
      appBar: NavBar(
        backgroundColor: BROWN_DARK,
        withBack: true,
        //textColor: GREEN_DARK,
        text: "Pick a day for delivering residues",
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(height: 30),
        Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Button1(
                  btnData: ButtonData('SELECT A DATE', () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime(2020, 11, 23),
                  firstDate: start,
                  //aca seria la primer aparicion del ecopoint desde hoy, que sea posible
                  lastDate: end,
                  //aca seria la ultima aparicion del ecopoint
                  selectableDayPredicate: (DateTime val) =>
                      notAvailableWeekDays[val.weekday - 1],
                  // val.weekday == 5 ? false : true,
                ).then((value) {
                  _date = value;
                });
              }))),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Button1(
              btnData: ButtonData(
                'CONTINUE',
                () {
                  Navigator.pushNamed(context, '/pickTime', arguments: {
                    'timeStart': "17:00",
                    'timeEnd': "20:00",
                    'date':
                        "${getWeekDay(_date.weekday)} ${_date.day} ${getMonth(_date.month)} of ${_date.year}",
                  });
                },
                backgroundColor: GREEN_LIGHT,
              ),
            ),
          ),
        ),
      ]),
    );
  }

//   return Scaffold(
//     backgroundColor: BROWN_DARK,
//     appBar: NavBar(
//       backgroundColor: BROWN_DARK,
//       withBack: true,
//       //textColor: GREEN_DARK,
//       text: "Pick a day for delivering residues",
//     ),
//     body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//       SizedBox(height: 30),
//       Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: TimeslotCard(
//             testList //arguments,
//           ),
//         ),
//       ),
//       Center(
//         child: Padding(padding: const EdgeInsets.symmetric(horizontal: 40),
//
//           child: Button1(
//           btnData: ButtonData(
//             'CONTINUE',
//                 () {Navigator.pushNamed(context, '/pickTime',
//                     arguments: {
//                       'timeStart': "17:00",
//                       'timeEnd': "20:00",
//                       'date': "Wednesday 26th October",
//                     });},
//             backgroundColor: GREEN_LIGHT,
//           ),
//         ),
//         ),
//       ),
//     ]),
//   );
// }
}

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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 330,
                  child: ListView(
                      children: List<Widget>.generate(this.timeslots.length,
                          (int index) {
                    return Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      ChoiceChip(
                        label: Container(
                            width: 240,
                            height: 40,
                            child: Center(
                              child: Text(
                                this.timeslots[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            )),
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
                    ]);
                  }).toList())),
              Container(
                  width: 260,
                  height: 50,
                  decoration: BoxDecoration(
                    color: BROWN_DARK,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Arrange personally with $_ecollector",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ))),
              SizedBox(height: 0)
            ]));
  }
}
