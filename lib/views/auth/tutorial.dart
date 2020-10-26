import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import 'package:econet/presentation/constants.dart';

class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          NavBar(
            text: 'Tutorial',
            withBack: true,
            backgroundColor: Colors.white,
            textColor: GREEN_MEDIUM,
            height: 120,
          ),
          SizedBox(height: 20),
          Container(
            width: 309,
            height: 479,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.black),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                ),
                onPressed: () {},
                iconSize: 50.0,
              ),
            ),
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/GMap');
            },
            child: Text(
              'Skip Tutorial',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: BROWN_DARK,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFProDisplay'),
            ),
          )
        ],
      ),
    );
  }
}
