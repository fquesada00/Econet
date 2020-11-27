import 'dart:collection';

import 'package:econet/model/timeslot.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:flutter/src/widgets/framework.dart';

class PickDelivery extends StatelessWidget {
  static final int WEEKDAYS = 7;

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
    for (int i = 0; i < list.length; i++) ret[list[i].weekDay - 1] = true;
    return ret;
  }

  int nextDay(int day, int totalDays, int maxDay) {
    if (day == maxDay) return totalDays;
    for (int i = 0; i < totalDays; i++) {
      if (day == maxDay) day = 0;
      day++;
    }
    return day;
  }

  int nextMonth(int day, int month, int totalDays) {
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return nextDay(day, totalDays, 31);
      case 2:
        if (DateTime.now().year % 4 == 0) {
          return nextDay(day, totalDays, 29);
        }
        return nextDay(day, totalDays, 28);
      default:
        return nextDay(day, totalDays, 30);
    }
  }

  // recibo el array ordenado, tanto por timeSlot como por timeRange
  DateTime firstDate(List<TimeSlot> list) {
    DateTime start, end;
    DateTime _date = DateTime.now();
    int currentMonth = _date.month;
    int currentDay = _date.day;
    int currentWeekDay = _date.weekday;
    int currentYear = _date.year;
    int listIdx = -1;
    for (int i = 0; i < list.length; i++) {
      if (list[i].weekDay >= currentWeekDay) {
        listIdx = i;
        break;
      }
    }
    if (listIdx == -1) listIdx = 0;
    for (int i = listIdx, j = 0; j < list.length; j++) {
      for (int k = 0; k < list[i].ranges.length; k++) {
        if (currentWeekDay.compareTo(list[i].weekDay) != 0) {
          int totalDays = currentWeekDay - list[i].weekDay;
          currentDay = nextMonth(currentDay, currentMonth, totalDays.abs());
          if (currentDay == 1) {
            currentMonth = currentMonth == 12 ? 1 : (currentMonth + 1);
            if (currentMonth == 1) currentYear++;
          }
          currentWeekDay = list[i].weekDay;
        }
        start = DateTime(currentYear, currentMonth, currentDay,
            list[i].ranges[k].first.hour, list[i].ranges[k].first.minute);
        end = DateTime(currentYear, currentMonth, currentDay,
            list[i].ranges[k].last.hour, list[i].ranges[k].last.minute);
        if (_date.isAfter(start) && _date.isBefore(end)) {
          return _date;
        } else if (_date.isBefore(start)) {
          return start;
        }
        i = i == (list.length - 1) ? 0 : (i + 1);
      }
    }
    // no hubo match
    return null;
  }

  DateTime lastDate(List<TimeSlot> list, DateTime endCollect) {
    DateTime _date = DateTime.now();
    int currentWeekDay = _date.weekday;
    int listIdx = -1;
    for (int i = 0; i < list.length; i++)
      if (list[i].weekDay < currentWeekDay) listIdx = i;
    if (listIdx == -1) listIdx = list.length - 1;
    return DateTime(
        endCollect.year,
        endCollect.month,
        endCollect.day,
        list[listIdx].ranges[list[listIdx].ranges.length - 1].last.hour,
        list[listIdx].ranges[list[listIdx].ranges.length - 1].last.minute);
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
    TimeSlot t3 = TimeSlot(4);

    TimeOfDay t = TimeOfDay(hour: 20, minute: 00);
    print("${t.minute}" + " ee ${t}");

    t1.addRange('20:00', '23:59');
    t1.addRange('15:00', '20:00');
    t1.addRange('19:00', '20:01');

    t2.addRange('10:00', '20:00');

    t3.addRange('09:00', '10:00');

    t1.ranges.sort();
    DateTime _date;

    List<TimeSlot> list = List();
    list.add(t2);
    list.add(t1);
    list.add(t3);
    list.sort();
    list.forEach((elementT) {
      print("ElementT: ${elementT.weekDay}");
      elementT.ranges.forEach((element) {
        print("${element}");
      });
    });

    DateTime startCollect = DateTime(2020, 2, 13);
    DateTime endCollect = DateTime(2021, 2, 13);

    DateTime start = firstDate(list);
    DateTime end = lastDate(list, endCollect);

    List<bool> notAvailableWeekDays = unavailableWeekDays(list);
    print("${notAvailableWeekDays.toString()}");

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
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Button1(
                  btnData: ButtonData('SELECT A DATE', () {
                showDatePicker(
                  context: context,
                  initialDate: start,
                  firstDate: start,
                  //aca seria la primer aparicion del ecopoint desde hoy, que sea posible
                  lastDate: end,
                  //aca seria la ultima aparicion del ecopoint
                  selectableDayPredicate: (DateTime val) =>
                      notAvailableWeekDays[val.weekday - 1],
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
                    'timeStart': "${start.hour}:${start.minute}",
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
