import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/InformationCard.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickDeliveryDate extends StatefulWidget {
  @override
  _PickDeliveryDateState createState() => _PickDeliveryDateState();
}

class _PickDeliveryDateState extends State<PickDeliveryDate> {
  DateTime _date;
  TimeOfDay _time;
  ButtonData btnDataContinue;
  CreateEcopointModel createEcopointModel = CreateEcopointModel.instance;
  var scaffoldKey = GlobalKey<ScaffoldState>();

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

  void displaySnackBar(BuildContext context) {
    String msg;
    if (_date == null)
      msg = 'a date';
    else if (_time == null)
      msg = 'an hour';
    else
      msg = 'a date'; //No entraria nunca
    SnackBar snackBar = SnackBar(
      content: Text(
        'Please select $msg',
        style: TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(
        label: 'Undo',
        textColor: Colors.blue,
        onPressed: () {
          scaffoldKey.currentState.hideCurrentSnackBar();
        },
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  String displayMsg() {
    String msg;
    if (_time == null && _date == null)
      msg = 'Please select a day and hour';
    else if (_time == null)
      msg = 'Your selected day is';
    else
      msg = 'Your selected date is';
    return msg;
  }

  String displayDate() {
    String msg;
    if (_date != null && _time != null)
      msg = '${getWeekDay(_date.weekday)} - ${_date.day >= 10 ? _date.day : '0' + _date.day.toString()}/${_date.month >= 10 ? _date.month : '0' + _date.month.toString()}/${_date.year}' +
          '\n${_time.hour >= 10 ? _time.hour : '0' + _time.hour.toString()}:${_time.minute >= 10 ? _time.minute : '0' + _time.minute.toString()} hs';
    else if (_date == null)
      msg = '---\n';
    else
      msg =
          '${getWeekDay(_date.weekday)} - ${_date.day >= 10 ? _date.day : '0' + _date.day.toString()}/${_date.month >= 10 ? _date.month : '0' + _date.month.toString()}/${_date.year}';
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime _actual = DateTime.now().toLocal();
    print("testing create ecopointModel in pickDeliveryDate.dart - residues:");
    print(createEcopointModel.selectedResidues);
    List<Widget> timeslots = List();
    for (int i = 0; i < 20; i++)
      timeslots.add(Container(
        child: Text(
          'value ' + i.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
      ));

    btnDataContinue = ButtonData(
      "CONTINUE",
      () {
        if (_time == null || _date == null)
          displaySnackBar(context);
        else {
          createEcopointModel.deliveryTime = _time;
          createEcopointModel.deliveryDate = _date;
          Navigator.pushNamed(context, '/pickWeekday');
        }
      },
      enabled: true,
      textColor: Colors.white,
      backgroundColor: Colors.indigo[400],
    );
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.indigo[200],
      appBar: NavBar(
        backgroundColor: Colors.indigo[200],
        withBack: true,
        text: 'Pick a date for delivering residues',
        textColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Container(
            width: 360,
            height: 200,
            child: InformationCard(
                name: 'Open hours',
                nameColor: GREEN_DARK,
                content: Container(
                  height: 100,
                  child: ListView.builder(
                    itemBuilder: (context, idx) {
                      return timeslots[idx];
                    },
                    itemCount: timeslots.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: ScrollController(),
                  ),
                )),
          ),
          Container(
            width: 350,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              children: [
                // Text(
                //   displayMsg(),
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontFamily: 'SFProDisplay',
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  displayDate(),
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: Button1(
                    btnData: ButtonData(
                      "SELECT A DATE",
                      () {
                        showDatePicker(
                          context: context,
                          initialDate: _date == null ? _actual : _date,
                          firstDate: _actual,
                          lastDate:
                              DateTime(DateTime.now().year + 100).toLocal(),
                          //Se puede modificar a mayor/menor
                          selectableDayPredicate: (DateTime value) => true,
                        ).then((value) {
                          if (value == null) return;
                          _date = value;
                          showTimePicker(
                                  context: context,
                                  initialTime: _time == null
                                      ? TimeOfDay(
                                          hour: _actual.hour,
                                          minute: _actual.minute)
                                      : _time)
                              .then((value) {
                            _time = (value == null) ? _time : value;
                            if (_time != null) {
                              btnDataContinue.enabled = true;
                              print("${btnDataContinue.enabled}");
                            }
                            setState(() {
                              //TODO: Arreglar bug cuando elegis fecha, cancelas antes de elegir hora, elegis fecha y hora y no te deja continuar
                            });
                          });
                        });
                      },
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Button1(btnData: btnDataContinue),
          ),
        ],
      ),
    );
  }
}
