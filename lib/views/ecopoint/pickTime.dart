import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:flutter/src/widgets/framework.dart';
class PickTime extends StatefulWidget {
  //EcopointInfo({this.adress);
  //String adress;
  @override
  State<StatefulWidget> createState() => PickTimeState();
}


class PickTimeState extends State<PickTime> {

  int _currentMinute = 0;
  int _currentHour = 17;
  int _startHour;
  int _startMinute;
  int _endHour;
  int _endMinute;
  bool _isLowTime;
  bool _isHighTime;

  void addTime(){
    print("addTime");
    if(!((_currentHour == _endHour) && (_currentMinute == _endMinute))){
      _isLowTime = false;
      _currentMinute = (_currentMinute + 1)%4;
      if (_currentMinute == 0){
        _currentHour +=1;
      }
    }
    print((_currentHour == _endHour));
    print((_currentMinute == _endMinute));
    if((_currentHour == _endHour) && (_currentMinute == _endMinute)){
      print("is highTime!");
      _isHighTime = true;
    }
    setState(() {});
   }
  void removeTime(){
    _isLowTime = true;
    if(!((_currentHour == _startHour) && (_currentMinute == _startMinute))){
      _isHighTime = false;
      _currentMinute = _currentMinute - 1;
      if (_currentMinute < 0){
        _currentHour -=1;
        _currentMinute = 3;
      }
    }
    if((_currentHour == _endHour) && (_currentMinute == _endMinute)){
      _isLowTime = true;
    }
    setState(() {});
   }
  @override
  Widget build(BuildContext context) {
    final Map _arguments = ModalRoute.of(context).settings.arguments as Map;
    _startHour = 17; //Should be something like _arguments["timeStart"]
    _startMinute = 0;
    _endHour = 20;
    _endMinute = 0;
    _isLowTime = false;
    _isHighTime = false;
    //final List<String> arguments = ModalRoute.of(context).settings.arguments as List<String>;
    final testList = List<String>(10);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BROWN_DARK,
      appBar: NavBar(
        backgroundColor: BROWN_DARK,
        withBack: true,
        //textColor: GREEN_DARK,
        text: "Aproximate time for delivering residues",
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        SizedBox(height: 30),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(_arguments["date"],style:TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700
                      )),
                      Text("Available: " + _arguments["timeStart"] + " - " +  _arguments["timeEnd"],style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ))
                    ],
                  ),
                  new Material(color: Colors.white,child: Container(width: 300,height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[
                          IconButton(
                            splashRadius: 30,
                            splashColor: BROWN_LIGHT,
                            disabledColor: Colors.grey,
                            icon: Icon(CustomIcons.plus_circle),
                            onPressed: _isHighTime ? null : (){addTime();
                            setState(() {_isHighTime = true;});},
                            iconSize: 35,
                          ),
                          Text(_currentHour.toString() + ":" + (_currentMinute*15).toString().padLeft(2, '0'),style:TextStyle(
                            fontSize: 63,
                          )),
                          IconButton(
                            splashRadius: 30,
                            splashColor: BROWN_LIGHT,
                            disabledColor: Colors.grey,
                            icon: Icon(CustomIcons.minus_circle),
                            onPressed: _isLowTime ? null : removeTime,
                            iconSize: 35,
                          ),
                        ]
                      ))),
                  SizedBox()
                ],
              )
            )
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

      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
        Container(height: 330,child:
        ListView(
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
            ),
          child:
            Center(
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
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
