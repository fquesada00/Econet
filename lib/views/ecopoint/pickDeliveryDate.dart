import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/timeslot.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/InformationCard.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/open_hours_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickDeliveryDate extends StatefulWidget {
  @override
  _PickDeliveryDateState createState() => _PickDeliveryDateState();
}

class _PickDeliveryDateState extends State<PickDeliveryDate> {
  DateTime _date;
  TimeOfDay _time;
  CreateEcopointModel _createEcopointModel = CreateEcopointModel.instance;
  Ecopoint ecopoint;
  Function _continueFunction;
  bool alreadyCreated = false;
  ScrollController controller = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
  void initState() {
    print("init");
    super.initState();

    if (_time == null) {
      _continueFunction = () {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Center(
            heightFactor: 1,
            child: Text(
              'Please select a value',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
      };
    }

    if (_createEcopointModel.deliveryDate != null) {
      _date = _createEcopointModel.deliveryDate;
      _time = _createEcopointModel.deliveryTime;
      _continueFunction = () {
        if (ecopoint != null) {
          //TODO: POST A API CON LOS CAMBIOS DE LA FECHA DE ENTREGA, DIA EN _DATE y HORA EN _TIME
          // LA INFORMACION DE ECOPOINT ESTA EN ecopoint
          Navigator.pop(context);
        } else {
          _createEcopointModel.deliveryTime = _time;
          _createEcopointModel.deliveryDate = _date;
          Navigator.pushNamed(context, '/pickWeekday');
        }
      };
    }
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

    if (!alreadyCreated) {
      ecopoint = ModalRoute.of(context).settings.arguments;
      if (ecopoint != null) {
        _date = ecopoint.deadline;
        _time = TimeOfDay.fromDateTime(_date);
      }
      alreadyCreated = !alreadyCreated;
    }

    List<Widget> timeslots = List();
    _createEcopointModel.plant.openHours.forEach((e) {
      timeslots.add(Container(
        margin: EdgeInsets.only(top: 3, bottom: 3, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                e.toStringDay() + ": ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    e.toStringRanges(),
                    maxLines: 5,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    });

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.indigo[200],
      appBar: NavBar(
        backgroundColor: Colors.indigo[200],
        withBack: true,
        text: 'Pick a date for delivering residues',
        textColor: Colors.black,
      ),
      body: Builder(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //   SizedBox(
            //   height: 70,
            // ),
            Container(
              width: 360,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: InformationCard(
                name: 'Open hours',
                nameColor: GREEN_DARK,
                content: Container(
                  height: 80,
                  child: ListView.builder(
                    itemBuilder: (context, idx) {
                      return timeslots[idx];
                    },
                    itemCount: timeslots.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: ScrollController(),
                  ),
                ),
              ),
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
                  SizedBox(
                    height: 15,
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Button1(
                      btnData: ButtonData(
                        "SELECT A DATE",
                        () {
                          showDatePicker(
                            context: context,
                            initialDate: _actual,
                            firstDate: _actual,
                            lastDate: DateTime(2100).toLocal(),
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

                              setState(() {
                                if (_time != null) {
                                  print("set");
                                  _continueFunction = () {
                                    if (ecopoint != null) {
                                      //TODO: POST A API CON LOS CAMBIOS DE LA FECHA DE ENTREGA, DIA EN _DATE y HORA EN _TIME
                                      // LA INFORMACION DE ECOPOINT ESTA EN ecopoint
                                      Navigator.pop(context);
                                    } else {
                                      _createEcopointModel.deliveryTime = _time;
                                      _createEcopointModel.deliveryDate = _date;
                                      Navigator.pushNamed(
                                          context, '/pickWeekday');
                                    }
                                  };
                                }
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
            Center(
              child: Hero(
                tag: 'ContinueButton',
                child: Button1(
                    btnData: ButtonData(
                  "CONTINUE",
                  () {
                    setState(() {});
                    _continueFunction();
                  },
                  textColor: Colors.white,
                  backgroundColor: Colors.indigo[400],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
