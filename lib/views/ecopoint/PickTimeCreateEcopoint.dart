import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/time_picker.dart';
import 'package:flutter/src/widgets/framework.dart';




class PickTimeCreateEcopoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final testList = List<String>();
    final createEcopointModel = CreateEcopointModel.instance;

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
                        () {
                          int i = arguments["currentDay"]+1;
                          bool nextDay = createEcopointModel.chosenWeekdays.length>= i;
                          print(createEcopointModel.chosenWeekdays.length);
                          print(i);
                          print("hey");
                          if(nextDay){
                            Navigator.pushNamed(context, '/pickTimeCreateEcopoint',
                                arguments: {
                                  "currentDay": i,
                                  "daysAvailable": arguments["daysAvailable"],
                                });
                          }else{
                            print("Push to nextwhateveritis in the else part of the button");
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


class TimeslotCard extends StatefulWidget {

  final Map arguments;

  TimeslotCard(this.arguments);

  @override
  TimeslotCardState createState() => TimeslotCardState(this.arguments);
}

class TimeslotCardState extends State<TimeslotCard> {

  final Map arguments;

  //bool _isSelected = false;
  //Color textColor = Colors.white;
  TimeslotCardState(this.arguments);
  int _value = -1;
  final String _ecollector = 'Beto';



  @override
  Widget build(BuildContext context) {
    int currentDay = this.arguments["currentDay"];
    List<DateTime> chosenWeekdays = CreateEcopointModel.instance.chosenWeekdays;
    Size size = MediaQuery.of(context).size;
    CreateEcopointModel createEcopointModel = CreateEcopointModel.instance;
    print("currentDay");
    print(createEcopointModel.timeslotsWeekdays.length);
    int numberOfRanges = createEcopointModel.getRangesOfDay(currentDay).length;
    print(this.arguments);
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
                  WEEKLIST[chosenWeekdays[currentDay].weekday-1] + " " +
                      chosenWeekdays[currentDay].day.toString()+
                      "/"+
                      chosenWeekdays[currentDay].month.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.black,
              ),
              ),
              Container(height: 288,child:
              ListView(
                  children: List<Widget>.generate(numberOfRanges, (int index) {
                    return Column(children:[SizedBox(height: 10,),
                      ChoiceChip(
                        label: Container(
                            width: 240,
                            height: 40,
                            child:
                            Center(child: Text(
                              createEcopointModel.getRangesOfDay(arguments["currentDay"])[index].toString(),
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
                              //createEcopointModel.addTimeslot(arguments["currentDay"], '17:00','19:00');
                              showDialog(
                                  context: context,
                                  builder: (BuildContext DialogContext){return TimePicker(isStartTime: true,weekday: arguments["currentDay"],);},)
                                  .then((value){
                                if(value != null){
                                  setState(() {
                                    //_value = selected ? index : null;
                                    print("TIMESLOT ADDED");
                                    print(numberOfRanges);
                                    numberOfRanges = createEcopointModel.getRangesOfDay(arguments["currentDay"]).length;
                                    print(numberOfRanges);
                                    print("afterNumberOfRanges");
                                  });
                                }
                              });
                              },
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
