import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/model/create_ecopoint_view_model.dart';

class TimePicker extends StatefulWidget{
  bool isStartTime;
  bool isEndTime;
  int weekday;
  int startHour;
  int startMinute;
  TimePicker({this.isStartTime,this.isEndTime,@required this.weekday,this.startHour,this.startMinute});

  @override
  State<StatefulWidget> createState() => TimePickerState(this.isStartTime,this.isEndTime,this.weekday,this.startHour,this.startMinute);

}

class TimePickerState extends State<TimePicker>{
  CreateEcopointModel ecopointModel = CreateEcopointModel.instance;
  int _currentMinute = 0;
  int _currentHour = 0;
  int _startHour;
  int _startMinute;
  int _endHour;
  int _endMinute;
  bool _isLowTime = false;
  bool _isHighTime = false;
  bool _isLowHour = false;
  bool _isHighHour = false;
  final bool isStartTime;
  final bool isEndTime;
  int weekday;
  bool _hasLoaded = false;

  String _timeType = "";
  String _buttonText = "";
  TimePickerState(this.isStartTime,this.isEndTime,this.weekday,this._startHour,this._startMinute);
  updateStates(){
    bool _isLowMinute = false;
    bool _isHighMinute = false;
    bool _isLowHour = false;
    bool _isHighHour = false;
    if (!(_currentHour < _endHour)){
      if (!(_currentHour+1 < _endHour)){
        _isLowHour = true;
      }else if (!(_currentHour+1 == _endHour) && (_currentMinute<=_endMinute)){
        _isLowHour = true;
      }
    }
    if (!(_currentHour > _startHour)) {
      if (!(_currentHour - 1 > _startHour)) {
        _isLowHour = true;
      }
      else if (!(_currentHour - 1 == _startHour) &&
          (_currentMinute <= _startMinute)) {
        _isLowHour = true;
      }
    }
    if ((_currentHour == _endHour) && (_currentMinute == _endMinute)) {
      print("is highTime!");
      _isHighMinute = true;
    }
    if ((_currentHour == _startHour) && (_currentMinute == _startMinute)) {
      _isLowMinute = true;
    }
    setState(() {});
  }

  void addHour() {
    print("addHour");
    if ((_currentHour) < _endHour){
      if ((_currentHour+1) < _endHour){
        _currentHour += 1;
      }else if ((_currentHour+1 == _endHour) && (_currentMinute<=_endMinute)){
        _currentHour += 1;
      }
    }
    updateStates();
  }
  void removeHour() {
    print("RemoveHour");
    if (_currentHour > _startHour){
      if (_currentHour-1 > _startHour){
        _currentHour -= 1;
      }else if ((_currentHour-1 == _startHour) && (_currentMinute>=_startMinute)){
        _currentHour -= 1;
      }
    }

    updateStates();

  }

  void addMinutes() {
    print("addTime");
    if (!((_currentHour == _endHour) && (_currentMinute == _endMinute))) {
      _currentMinute = (_currentMinute + 1) % 4;
      if (_currentMinute == 0) {
        _currentHour += 1;
      }
    }
    updateStates();
  }

  void removeMinutes() {
    print("removeTime");
    if (!((_currentHour == _startHour) && (_currentMinute == _startMinute))) {
      _currentMinute = _currentMinute - 1;
      if (_currentMinute < 0) {
        print("is lowTime!");

        _currentHour -= 1;
        _currentMinute = 3;
      }
    }
    updateStates();

  }

  void firstLoad(){
    DateTime deliveryTime = ecopointModel.deliveryDate;

    if (this.isStartTime != null){
      _timeType = "start-time";
      _buttonText = "Next";
    }else if(this.isEndTime != null){
      _timeType = "end-time";
      _buttonText = "Add timeslot";
    }
    _endHour = 24;
    _endMinute = 0;
    if(ecopointModel.getRangesOfDay(weekday).length != 0 && (_startHour == null || _startMinute == null)){
      final dayList = ecopointModel.getRangesOfDay(weekday);
      _startHour = dayList[dayList.length-1].last.hour;
      _startMinute = (dayList[dayList.length-1].last.minute/15).toInt();
      _currentHour = _startHour;
      _currentMinute = _startMinute;
    }else if(_startHour != null && _startMinute != null){
      _currentHour = _startHour;
      _currentMinute = _startMinute;
    }else{
      _startHour = 0;
      _startMinute = 0;
      _currentHour = 7;
      _currentMinute = _startMinute;
    }
    _hasLoaded = true;
  }
  Widget build(BuildContext context) {
    if(!_hasLoaded){
      firstLoad();
      print("First load of time_picker");
    }

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
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                IconButton(
                  splashRadius: 27,
                  splashColor: BLUE_MEDIUM,
                  disabledColor: Colors.grey,
                  icon: Icon(CustomIcons.plus_circle),
                  constraints: BoxConstraints(
                    minWidth: 60,
                    minHeight: 60,
                  ),
                  onPressed: _isHighHour ? null : () {
                    print("high is pressed, isHighTime");
                    print(_isHighTime);
                    addHour();
                    setState(() {});
                  },
                  iconSize: 35,
                ),IconButton(
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
                      addMinutes();
                      setState(() {});
                    },
                    iconSize: 35,
                  ),]

              ),
              Text(
                  _currentHour.toString().padLeft(2, '0') +
                      ":" +
                      (_currentMinute * 15)
                          .toString()
                          .padLeft(2, '0'),
                  style: TextStyle(
                      fontSize: 63,
                      fontWeight: FontWeight.w700)
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                IconButton(
                  splashRadius: 27,
                  splashColor: BLUE_MEDIUM,
                  disabledColor: Colors.grey,
                  icon: Icon(CustomIcons.minus_circle),
                  onPressed:_isLowHour ? null :() {
                    print("low is pressed, isLowTime");
                    print(_isLowTime);
                    removeHour();
                    setState(() {});
                  },
                  iconSize: 35,
                ),IconButton(
                  splashRadius: 27,
                  splashColor: BLUE_MEDIUM,
                  disabledColor: Colors.grey,
                  icon: Icon(CustomIcons.minus_circle),
                  onPressed:_isLowTime ? null :() {
                    print("low is pressed, isLowTime");
                    print(_isLowTime);
                    removeMinutes();
                    setState(() {});
                  },
                  iconSize: 35,
                ),]
              ),
              SizedBox(height: 5),
              Button1(
                btnData: ButtonData(
                  _buttonText,
                      () {
                    if(this.isStartTime!=null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext DialogContext){
                          return TimePicker(isEndTime: true,weekday: weekday,startHour: _currentHour,startMinute: _currentMinute);})
                      .then((value){
                        if(value){
                          Navigator.pop(context, true);
                        }
                      });
                    }else{
                      //It comes here after both times has been picked
                      if (!((_startHour == _currentHour && _startMinute == _currentMinute))) {

                        ecopointModel.addTimeslot(
                            weekday, _startHour, _startMinute * 15,
                            _currentHour, _currentMinute * 15);

                        Navigator.pop(context, true);
                      }else{
                        print("Timeslot has to be at least 15 minutes long");
                      }
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