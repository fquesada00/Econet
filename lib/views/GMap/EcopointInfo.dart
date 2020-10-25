import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/GMap/EconetButton.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/button_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EcopointInfo extends StatefulWidget{
  //EcopointInfo({this.adress);
  //String adress;
  @override
  State<StatefulWidget> createState() => EcopointInfoState();
}

class EcopointInfoState extends State<EcopointInfo>{
  //EcopointInfoState({this.adress});
  //String adress;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 300,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: 12.0),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,
                    children:
                    [SizedBox(width: 10),
                      Text("Beto",style: TextStyle(fontSize: 40),),
                    SizedBox(width: 30),
                    Text("0,2 km",textAlign: TextAlign.left),]),
              Padding(padding: const EdgeInsets.all( 12.0),
                child: Icon(CustomIcons.times_circle, size: 30),
              ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //SizedBox(width: 10),
              Icon(CustomIcons.map_pin),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFe5e2e2),
                  //color: Colors.grey,
                ),
                height: 35,
                width: 300,
                alignment: Alignment(0,0),
                child: Text(
                  "Esto es una calle real 1234",
                  textScaleFactor: 1.3,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //SizedBox(width: 10),
              Icon(CustomIcons.recycle),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFe5e2e2),
                  //color: Colors.grey,
                ),
                height: 76,
                width: 300,
                alignment: Alignment(0,0),
                child: materialRow("Paper",0xFFC7A26B,"Plastic",0xFF6B7AC7,"Glass",0xFF6BB7C7),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Button1(
                btnData: ButtonData(
                    text: 'OPEN ECOPOINT',
                    color: GREEN_MEDIUM,
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup_method');
                    })),
          ),
        ],

      )
    );
  }
}
//Creates a row for the materials such as paper or glass
Widget materialRow(text1, color1, text2, color2,text3,color3){
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Color(color1),
            //color: Colors.grey,
          ),
          height: 30,
          width: 80,
          alignment: Alignment(0,0),
          child: Text(
            text1,
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(width: 7),
        Container(
          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Color(color2),
            //color: Colors.grey,
          ),
          height: 30,
          width: 80,
          alignment: Alignment(0,0),
          child: Text(
            text2,
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(width: 7),
        Container(
          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Color(color3),
            //color: Colors.grey,
          ),
          height: 30,
          width: 80,
          alignment: Alignment(0,0),
          child: Text(
            text3,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ]
  );
}