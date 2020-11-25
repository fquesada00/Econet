import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:flutter/src/widgets/framework.dart';



class PickTimeCreateEcopoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final testList = List<String>();
    testList.add("15:30-17:30");
    testList.add("19:30-21:00");

    return Scaffold(
      backgroundColor: BROWN_DARK,
      appBar: NavBar(
        backgroundColor: BROWN_DARK,
        withBack: true,
        //textColor: GREEN_DARK,
        text: "Add your desired timeslots for the day",
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 30),
            Column(children:[
              Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TimeslotCard(
                    testList,
                    arguments,
                ),
              ),
            ),
            ]
            ),
            Center(
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 40),

                child: Button1(
                  btnData: ButtonData(
                    'CONTINUE',
                        () {Navigator.pushNamed(context, '/pickTime',
                        arguments: {
                          'timeStart': "17:00",
                          'timeEnd': "20:00",
                          'date': "Wednesday 26th October",
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
  final Map arguments;

  TimeslotCard(this.timeslots,this.arguments);

  @override
  TimeslotCardState createState() => TimeslotCardState(this.timeslots,this.arguments);
}

class TimeslotCardState extends State<TimeslotCard> {

  final List<String> timeslots;
  final Map arguments;
  //bool _isSelected = false;
  //Color textColor = Colors.white;
  TimeslotCardState(this.timeslots,this.arguments);
  int _value = -1;
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
              SizedBox(height: 10),
              Text(
              arguments["currentDay"],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 42,
                color: Colors.black,
              ),
              ),
              Container(height: 288,child:
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
                            print("OPEN TIMEPICKER HERE");
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child:
                  Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Button1(
                        btnData: ButtonData(
                        'ADD TIMESLOT',
                            () {
                            setState(() {
                              //_value = selected ? index : null;
                              print("TIMESLOT ADDED");
                              timeslots.add("ADD TIMESLOT HERE");
                            });},
                        backgroundColor: GREEN_LIGHT,
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