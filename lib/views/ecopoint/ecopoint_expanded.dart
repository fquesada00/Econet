import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/button_data.dart';

class EcopointExpanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      backgroundColor: GREEN_LIGHT,
      appBar: NavBar(
        backgroundColor: GREEN_LIGHT,
        withBack: true,
        textColor: GREEN_DARK,
        text: arguments['ecopointName'],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Center(
              child: EcollectorCard(),
            )
          ]),
    );
  }
}

class EcollectorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      child: Container(
        height: 200,
        width: 180,
        color: GREEN_DARK,
        alignment: Alignment.center,
        child: Container(
          height: 180,
          width: 170,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Ecollector',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white)),
              CircleAvatar(radius: 45, backgroundColor: Colors.white),
              Button1(
                btnData: ButtonData(
                  'Beto',
                  backgroundColor: Colors.white,
                  textColor: GREEN_DARK,
                  onPressed: () {},
                ),
                fontSize: 23,
                width: 80,
                height: 35,
                fontWeight: FontWeight.w600,
                adjust: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
