import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/model/timerange.dart';
import 'package:econet/model/timeslot.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class PickTimeCreateEcopoint extends StatefulWidget {
  @override
  _PickTimeCreateEcopointState createState() => _PickTimeCreateEcopointState();
}

class _PickTimeCreateEcopointState extends State<PickTimeCreateEcopoint> {
  List<TimeRange> timeRanges;

  void fillList() {
    timeRanges = List();
    for (var i = 1; i < 7; i++)
      timeRanges.add(TimeRange(
          first: TimeOfDay(hour: i, minute: 0),
          last: TimeOfDay(hour: i + 1, minute: 0)));
  }

  String getWeekDay(int n) {
    switch (n + 1) {
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
    }
  }

  int getNextPos(List<bool> selected, int init) {
    init += 1;
    print('init: ${init} and ${selected.length}');
    for (int i = init; i < selected.length; i++) {
      if (selected[i]) return i;
    }
    return -1;
  }

  int getWeekDayNumber(
      int init, int actualDay, List<bool> selected, int lastidx) {
    // actualDay +=1;
    print(init - lastidx);
    print(actualDay);
    print(lastidx);
    print('getweekdaynumber: ${selected.length}');
    for (int i = (lastidx + 1), j = 0; j < (init - lastidx); i++, j++) {
      actualDay = actualDay == 6 ? 0 : actualDay + 1;
      print("eee");
      print(i);
      print(actualDay);
      print(selected[i]);
      if (selected[i]) break;
    }
    // for (int i = init; i < 7; i++) {
    //   print(i);
    //   actualDay = actualDay == 6 ? 0 : actualDay + 1;
    //   if (selected[i]) break;
    // }
    print('actual day ${actualDay}');
    return actualDay;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final createEcopointModel = CreateEcopointModel.instance;
    Size size = MediaQuery.of(context).size;
    int day = arguments['currentDay'];
    print('pos: ${arguments['idx']} and day ${arguments['currentDay']}');
    // print("Testing ecopoint at PickTimeCreateEcopoint");
    // print("name");
    // print(createEcopointModel.name);
    // print("adress");
    // print(createEcopointModel.address);
    // print("selectedResidues");
    // print(createEcopointModel.selectedResidues);
    // print("deliveryDate");
    // print(createEcopointModel.deliveryDate);
    // print("deliveryTime");
    // print(createEcopointModel.deliveryTime);
    // print("availableWeekdays");
    // print(createEcopointModel.chosenWeekdays);
    return Scaffold(
      backgroundColor: BROWN_DARK,
      appBar: NavBar(
        backgroundColor: BROWN_DARK,
        withBack: true,
        //textColor: GREEN_DARK,
        text: "Add your desired timeslots for the day",
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(children: [
          Container(
            width: size.width * 0.8,
            height: 430,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  getWeekDay(day),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TimeRangeItem(
                    weekday: day,
                    timeRanges: createEcopointModel.getRangesOfDay(day),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button1(
                    btnData: ButtonData(
                      'ADD TIMESLOT',
                      () {
                        //createEcopointModel.addTimeslot(arguments["currentDay"], '17:00','19:00');
                        showDialog(
                          context: context,
                          builder: (BuildContext DialogContext) {
                            return TimeRangePicker(
                              weekday: day,
                              list: createEcopointModel.getRangesOfDay(day),
                            );
                          },
                        ).then((value) {
                          print(value.toString());
                          if (value == null) print('value is null');
                          if (value != null) {
                            // print('weekday ranges of day ${day}');
                            // print("${createEcopointModel.getRangesOfDay(day)}");
                            setState(() {});
                          }
                        });
                      },
                      backgroundColor: GREEN_MEDIUM,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ]),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Button1(
              btnData: ButtonData(
                'CONTINUE',
                () {
                  // int i = day == 7 ? 0 : arguments['currentDay'] + 1;
                  // bool nextDay =
                  //     createEcopointModel.chosenWeekdays.length > i &&
                  //         createEcopointModel.chosenWeekdays.length > 0;
                  // print(createEcopointModel.chosenWeekdays.length);
                  // print(i);
                  // print("hey");
                  List<bool> available = arguments['daysAvailable'];
                  // print('before ${available}');
                  int idx = getNextPos(available, arguments['idx']);
                  // available[idx] = false;
                  print('after ${available} and ${available.length}');
                  if (createEcopointModel.getRangesOfDay(day).isEmpty) {
                    //TODO popup/snackbar
                    print('CARGAR TIMESLOTS');
                  } else {
                    if (idx == -1) {
                      //TODO conectar con map
                      print('TE MANDO AL MAPA');
                      print('${createEcopointModel.timeslotsWeekdays}');
                      List<TimeSlot> list = List();
                      for (int i = 0;
                          i < createEcopointModel.timeslotsWeekdays.length;
                          i++) {
                        if (createEcopointModel
                                .timeslotsWeekdays[i].ranges.length !=
                            0) {
                          list.add(createEcopointModel.timeslotsWeekdays[i]);
                          // if((i+1) == createEcopointModel.timeslotsWeekdays.length)
                          //   createEcopointModel.timeslotsWeekdays.removeAt(i);
                          // else
                          //   createEcopointModel.timeslotsWeekdays.replaceRange(i, i+1, replacement)
                          // createEcopointModel.timeslotsWeekdays.removeAt(i);
                        }
                      }
                      createEcopointModel.timeslotsWeekdays = list;
                      print('${createEcopointModel.timeslotsWeekdays}');

                      Navigator.pushNamed(context, '/pickLocation');
                    } else {
                      print('before: ${available.length}');
                      Navigator.pushNamed(context, '/pickTimeCreateEcopoint',
                          arguments: {
                            "idx": idx,
                            "currentDay": getWeekDayNumber(
                                idx, day, available, arguments['idx']),
                            "daysAvailable": available,
                          });
                    }
                  }
                },
                backgroundColor: BROWN_MEDIUM,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class TimeRangePicker extends StatefulWidget {
  int weekday;
  TimeRange timeRange;
  List<TimeRange> list;

  TimeRangePicker({this.weekday, this.timeRange, this.list});

  @override
  _TimeRangePickerState createState() => _TimeRangePickerState();
}

class _TimeRangePickerState extends State<TimeRangePicker> {
  TimeOfDay first, last;
  String firstTime = '---';
  String lastTime = '---';
  final createEcopointModel = CreateEcopointModel.instance;

  @override
  Widget build(BuildContext context) {
    int idx = -1;
    if (widget.timeRange != null) {
      idx = widget.list.indexOf(widget.timeRange);
      firstTime = widget.timeRange.getFirstString();
      lastTime = widget.timeRange.getLastString();
      first = widget.timeRange.first;
      last = widget.timeRange.last;
    } else {
      if (first != null && last != null)
        idx = widget.list.indexOf(TimeRange(first: first, last: last));
      if (first != null) firstTime = first.toString().substring(10, 15);
      if (last != null) lastTime = last.toString().substring(10, 15);
    }
    return AlertDialog(
      title: Text(
        'Add a TimeSlot',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 25,
          color: Colors.black,
        ),
      ),
      content: Container(
        color: Colors.white,
        width: 300,
        height: 300,
        child: Column(
          children: [
            Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Start time',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 55,
                      ),
                      Container(
                        width: 170,
                        height: 50,
                        child: Center(
                          child: Text(
                            firstTime.length == 3
                                ? firstTime
                                : firstTime + 'hs',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        width: 40.0,
                        height: 40.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: idx == -1
                                        ? TimeOfDay(hour: 0, minute: 0)
                                        : first)
                                .then((value) {
                              first = value;
                              firstTime = value.toString().substring(10, 15);
                              if (widget.timeRange != null)
                                widget.timeRange.first = first;
                              setState(() {});
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'End time',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 55,
                      ),
                      Container(
                        width: 170,
                        height: 50,
                        child: Center(
                            child: Text(
                          lastTime.length == 3 ? lastTime : lastTime + 'hs',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        )),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(10)),),

                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        width: 40.0,
                        height: 40.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: idx == -1
                                        ? TimeOfDay(hour: 0, minute: 0)
                                        : last)
                                // initialTime: widget.timeRange == null
                                //     ? TimeOfDay(hour: 0, minute: 0)
                                //     : widget.timeRange.last)
                                .then((value) {
                              last = value;
                              lastTime = value.toString().substring(10, 15);
                              if (widget.timeRange != null)
                                widget.timeRange.last = last;
                              setState(() {});
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    if (first != null && last != null) {
                      //TODO function to check timeRange is not present in the list and is valid
                      if (widget.timeRange != null) {
                        int pos = createEcopointModel
                            .getRangesOfDay(widget.weekday)
                            .indexOf(TimeRange(first: first, last: last));
                        createEcopointModel.removeTimeslot(widget.weekday, pos);
                        // widget.list.removeAt(idx);
                      }
                      createEcopointModel.addTimeslot(widget.weekday,
                          first.hour, first.minute, last.hour, last.minute);
                      // widget.list.add(TimeRange(first: first, last: last));
                      // widget.list.sort();
                      print("lista de ${widget.weekday}");
                      print(
                          "${createEcopointModel.getRangesOfDay(widget.weekday)}");
                      Navigator.of(context).pop('ok');
                    } else {
                      //TODO show snackbar not all fields are fill w data
                      String msg = 'Missing ';
                      if (first == null && last == null)
                        msg += 'start and end hour';
                      else if (first == null)
                        msg += 'start hour';
                      else
                        msg += 'end hour';
                      print(msg);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeRangeItem extends StatefulWidget {
  List<TimeRange> timeRanges;
  int weekday;

  TimeRangeItem({this.timeRanges, this.weekday});

  @override
  _TimeRangeItemState createState() => _TimeRangeItemState();
}

class _TimeRangeItemState extends State<TimeRangeItem> {
  final createEcopointModel = CreateEcopointModel.instance;

  String parseTimeRange(TimeRange timeRange) {
    return timeRange.getFirstString() +
        'hs - ' +
        timeRange.getLastString() +
        'hs';
  }

  _buildList() {
    List<Widget> ranges = List();
    widget.timeRanges.forEach((element) {
      ranges.add(Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                child: Center(
                  child: Text(
                    parseTimeRange(element),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                width: 40.0,
                height: 40.0,
                child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext DialogContext) {
                          return TimeRangePicker(
                            weekday: widget.weekday,
                            timeRange: element,
                            list: createEcopointModel
                                .getRangesOfDay(widget.weekday),
                          );
                        },
                      ).then((value) {
                        if (value != null) {
                          setState(() {});
                        }
                      });
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                width: 40.0,
                height: 40.0,
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    int pos = createEcopointModel
                        .getRangesOfDay(widget.weekday)
                        .indexOf(element);
                    createEcopointModel.removeTimeslot(widget.weekday, pos);
                    // widget.timeRanges.remove(element);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ));
    });
    return ranges;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = _buildList();
    return ListView.builder(
      itemBuilder: (context, idx) {
        return list[idx];
      },
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: ScrollController(),
    );
  }
}
