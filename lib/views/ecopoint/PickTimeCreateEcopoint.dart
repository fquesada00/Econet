import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/model/timerange.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/time_picker.dart';
import 'package:flutter/src/widgets/framework.dart';

class PickTimeCreateEcopoint extends StatefulWidget {
  @override
  _PickTimeCreateEcopointState createState() => _PickTimeCreateEcopointState();
}

class _PickTimeCreateEcopointState extends State<PickTimeCreateEcopoint> {
  List<TimeRange> timeRanges = List();

  void fillList() {
    timeRanges = List();
    for (var i = 1; i < 7; i++)
      timeRanges.add(TimeRange(
          first: TimeOfDay(hour: i, minute: 0),
          last: TimeOfDay(hour: i + 1, minute: 0)));
  }

  String getWeekDay(int n) {
    switch (n) {
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

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final testList = List<String>();
    final createEcopointModel = CreateEcopointModel.instance;
    // if (timeRanges == null) fillList(); //Para test, hacer get en ViewModel

    print("${timeRanges}");
    print("Testing ecopoint at PickTimeCreateEcopoint");
    print("name");
    print(createEcopointModel.name);
    print("adress");
    print(createEcopointModel.address);
    print("selectedResidues");
    print(createEcopointModel.selectedResidues);
    print("deliveryDate");
    print(createEcopointModel.deliveryDate);
    print("deliveryTime");
    print(createEcopointModel.deliveryTime);
    print("availableWeekdays");
    print(createEcopointModel.chosenWeekdays);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BROWN_DARK,
      appBar: NavBar(
        backgroundColor: BROWN_DARK,
        withBack: true,
        //textColor: GREEN_DARK,
        text: "Add your desired timeslots for the day",
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(height: 30),
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
                  getWeekDay(arguments['currentDay']),
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
                    timeRanges: timeRanges,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Button1(
                  btnData: ButtonData(
                    'ADD TIMESLOT',
                    () {
                      //createEcopointModel.addTimeslot(arguments["currentDay"], '17:00','19:00');
                      showDialog(
                        context: context,
                        builder: (BuildContext DialogContext) {
                          return TimeRangePicker(
                            weekday: 1,
                            list: timeRanges,
                          );
                        },
                      ).then((value) {
                        print("$timeRanges");
                        if (value != null) {
                          setState(() {});
                        }
                      });
                    },
                    backgroundColor: GREEN_MEDIUM,
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
                  int i = arguments["currentDay"] == 7
                      ? 0
                      : arguments['currentDay'] + 1;
                  bool nextDay =
                      createEcopointModel.chosenWeekdays.length > i &&
                          createEcopointModel.chosenWeekdays.length > 0;
                  print(createEcopointModel.chosenWeekdays.length);
                  print(i);
                  print("hey");
                  List<bool> available = arguments['daysAvailable'];
                  available.removeAt(0);
                  if (available.length != 0) {
                    if (timeRanges.isEmpty)
                      int a; //TODO pop up / snackbar
                    else
                      Navigator.pushNamed(context, '/pickTimeCreateEcopoint',
                          arguments: {
                            "currentDay": i,
                            "daysAvailable": available,
                          });
                  } else {
                    //TODO conexion con el mapa
                    print(
                        "Push to nextwhateveritis in the else part of the button");
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

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

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
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
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
                      //TODO function to check timeRange is not present in the list
                      if (widget.timeRange != null) {
                        widget.list.removeAt(idx);
                      }
                      widget.list.add(TimeRange(first: first, last: last));
                      widget.list.sort();
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

  TimeRangeItem({this.timeRanges});

  @override
  _TimeRangeItemState createState() => _TimeRangeItemState();
}

class _TimeRangeItemState extends State<TimeRangeItem> {
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
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
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
                            weekday: 1,
                            timeRange: element,
                            list: widget.timeRanges,
                          );
                        },
                      ).then((value) {
                        if (value != null) {
                          setState(() {});
                        }
                      });
                    }),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    widget.timeRanges.remove(element);
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
