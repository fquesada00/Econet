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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime _actual = DateTime.now().toLocal();
    //TODO show snackbar cuando no hay fecha seleccionada
    btnDataContinue = ButtonData(
      "CONTINUE",
      () {
        Navigator.pushNamed(context, '/pickWeekday');
      },
      enabled: false,
      textColor: Colors.white,
      backgroundColor: Colors.indigo[400],
    );
    return Scaffold(
      backgroundColor: Colors.indigo[200],
      appBar: NavBar(
        backgroundColor: Colors.indigo[200],
        withBack: true,
        text: 'Pick a date for delivering residues',
        textColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: size.width * 0.8,
            height: size.height * 0.5 > 400 ? size.height * 0.5 : 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(
                  (_date == null || _time == null)
                      ? 'Please select a date first'
                      : 'Your selected date is',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(
                  (_date == null || _time == null)
                      ? '\n'
                      : '${getWeekDay(_date.weekday)} - ${_date.day >= 10 ? _date.day : '0' + _date.day.toString()}/${_date.month >= 10 ? _date.month : '0' + _date.month.toString()}/${_date.year}' +
                          '\n${_time.hour >= 10 ? _time.hour : '0' + _time.hour.toString()}:${_time.minute >= 10 ? _time.minute : '0' + _time.minute.toString()} hs',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 90.0, 20.0, 10.0),
                  child: Button1(
                    btnData: ButtonData(
                      "Select a date",
                      () async {
                        await showDatePicker(
                          context: context,
                          initialDate: _actual,
                          firstDate: _actual,
                          lastDate: DateTime(2100).toLocal(),
                          selectableDayPredicate: (DateTime value) => true,
                        ).then((value) async {
                          if (value == null) return;
                          _date = value;
                          await showTimePicker(
                                  context: context,
                                  initialTime: _time == null
                                      ? TimeOfDay(
                                          hour: _actual.hour,
                                          minute: _actual.minute)
                                      : _time)
                              .then((value) {
                            _time = (value == null) ? _time : value;
                            setState(() {
                              //TODO no pasa de vista en el caso:
                              /*
                              -selecciono fecha, cancelo
                              -selecciono fecha, hora y cancelo
                               */
                              if (_time != null) {
                                btnDataContinue.enabled = true;
                                print("${btnDataContinue.enabled}");
                              }
                            });
                          });
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Button1(btnData: btnDataContinue),
          ),
        ],
      ),
    );
  }
}
