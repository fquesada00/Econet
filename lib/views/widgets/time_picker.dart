import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:econet/presentation/custom_icons_icons.dart';

class TimePicker extends StatefulWidget{
  bool isStartTime;
  bool isEndTime;
  TimePicker({this.isStartTime,this.isEndTime});

  @override
  State<StatefulWidget> createState() => TimePickerState(this.isStartTime,this.isEndTime);

}

class TimePickerState extends State<TimePicker>{
  int _currentMinute = 0;
  int _currentHour = 17;
  int _startHour;
  int _startMinute;
  int _endHour;
  int _endMinute;
  bool _isLowTime = false;
  bool _isHighTime = false;
  final bool isStartTime;
  final bool isEndTime;

  String _timeType = "";
  String _buttonText = "";
  TimePickerState(this.isStartTime,this.isEndTime);
  void addTime() {
    print("addTime");
    if (!((_currentHour == _endHour) && (_currentMinute == _endMinute))) {
      _isLowTime = false;
      _currentMinute = (_currentMinute + 1) % 4;
      if (_currentMinute == 0) {
        _currentHour += 1;
      }
    }
    print((_currentHour == _endHour));
    print((_currentMinute == _endMinute));
    if ((_currentHour == _endHour) && (_currentMinute == _endMinute)) {
      print("is highTime!");
      _isHighTime = true;
    }
    setState(() {});
  }

  void removeTime() {
    print("removeTime");
    if (!((_currentHour == _startHour) && (_currentMinute == _startMinute))) {
      _isHighTime = false;
      _currentMinute = _currentMinute - 1;
      if (_currentMinute < 0) {
        print("is lowTime!");

        _currentHour -= 1;
        _currentMinute = 3;
      }
    }

    if ((_currentHour == _startHour) && (_currentMinute == _startMinute)) {
      _isLowTime = true;
    }
    print((_currentHour == _endHour));
    print((_currentMinute == _endMinute));
    setState(() {});
  }
  Widget build(BuildContext context) {
    if (this.isStartTime != null){
      _timeType = "start-time";
      _buttonText = "Next";
    }else if(this.isEndTime != null){
      _timeType = "end-time";
      _buttonText = "Add timeslot";
    }
    _startHour = 17; //Should be something like _arguments["timeStart"]
    _startMinute = 0;
    _endHour = 20;
    _endMinute = 0;

    return AlertDialog(
        title: Text("Pick your "+_timeType),
        content:Material(
        child: Container(
        color: Colors.white,
        width: 300,
        height: 300,
        child: Column(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                splashRadius: 27,
                splashColor: BLUE_MEDIUM,
                disabledColor: Colors.grey,
                icon: Icon(CustomIcons.plus_circle),
                constraints: BoxConstraints(
                  minWidth: 60,
                  minHeight: 60,
                ),
                onPressed: _isHighTime ? null : () {
                  print("high is pressed, isHighTime");
                  print(_isHighTime);
                  addTime();
                  setState(() {});
                },
                iconSize: 35,
              ),
              Text(
                  _currentHour.toString() +
                      ":" +
                      (_currentMinute * 15)
                          .toString()
                          .padLeft(2, '0'),
                  style: TextStyle(
                      fontSize: 63,
                      fontWeight: FontWeight.w700)
              ),
              IconButton(
                splashRadius: 27,
                splashColor: BLUE_MEDIUM,
                disabledColor: Colors.grey,
                icon: Icon(CustomIcons.minus_circle),
                onPressed:_isLowTime ? null :() {
                  print("low is pressed, isLowTime");
                  print(_isLowTime);
                  removeTime();
                  setState(() {});
                },
                iconSize: 35,
              ),
              SizedBox(height: 5),
              Button1(
                btnData: ButtonData(
                  _buttonText,
                      () {
                    if(this.isStartTime!=null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext DialogContext){return TimePicker(isEndTime: true);},);
                    }else{
                      print("poporquitorsmth");
                    }
                  },
                  backgroundColor: BROWN_MEDIUM,
                ),
              ),
            ]
        ))));
  }
}