import 'package:econet/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchInformation {
  String name;
  bool activated;

  SwitchInformation(String s, bool active) {
    name = s;
    activated = active;
  }
}

class SettingsAppTab extends StatefulWidget {
  double ecopoint_finder_radius =
      16.0; //valor default TODO: DEBERIA SER UN LIVEDATA O ALGO ASI PARA QUE PERMANEZCA EN CONFIGURACION DEL USUARIO
  static final double SLIDER_MAX_VALUE = 200;
  static final double SLIDER_MIN_VALUE = 1;

  @override
  _SettingsAppTabState createState() => _SettingsAppTabState();
}

class _SettingsAppTabState extends State<SettingsAppTab> {
  int unitsFormat = 0; // 0 = metric, 1 = imperial

  List<SwitchInformation> switchList = [
    SwitchInformation("Reminder notifications", true),
    SwitchInformation("Ecopoint delivery requests", true),
    SwitchInformation("Contact request", true),
    SwitchInformation("Ecopoint completion", true),
    //TODO: OBTENER VALOR DE LOS SWITCHS A PARTIR DE CONFIGURACION ANTERIOR DEL USUARIO
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 26, top: 26),
            child: Text(
              "Notifications",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'SFProDisplay',
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Column(
          children: List.generate(
            switchList.length,
            (index) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 56,
                color: Colors.grey.withOpacity(0.5),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 26),
                      child: Text(
                        switchList[index].name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'SFProText',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 26),
                      child: CupertinoSwitch(
                        activeColor: GREEN_DARK,
                        trackColor: Colors.grey.withOpacity(0.5),
                        onChanged: (bool value) {
                          setState(() {
                            switchList[index].activated = value;
                          });
                        },
                        value: switchList[index].activated,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 26, top: 26),
            child: Text(
              "Map",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'SFProDisplay',
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          width: double.infinity,
          color: Colors.grey.withOpacity(0.5),
          child: Column(
            children: [
              Container(
                height: 56,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 26),
                      child: Text(
                        "Ecopoint visibility radius: " +
                            widget.ecopoint_finder_radius
                                .truncate()
                                .toString() +
                            " km",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'SFProText',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 26, right: 26, bottom: 26),
                decoration: BoxDecoration(
                  color: GREEN_DARK,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "0 km",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SFProText',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SliderTheme(
                      child: Slider(
                        onChanged: (double value) {
                          setState(() {
                            widget.ecopoint_finder_radius = value;
                          });
                        },
                        value: widget.ecopoint_finder_radius,
                        min: 0,
                        max: 200,
                        divisions: 40,
                        label: widget.ecopoint_finder_radius
                                .truncate()
                                .toString() +
                            " km",
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                      ),
                      data: SliderTheme.of(context).copyWith(
                        valueIndicatorColor: Colors.white,
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "200 km",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SFProText',
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
