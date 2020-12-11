import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BecomeEcollector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: NavBar(
        text: "",
        withBack: true,
        backgroundColor: GREEN_LIGHT,
      ),
      backgroundColor: GREEN_LIGHT,
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              'Become an Ecollector!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: GREEN_DARK,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                  "Create Ecopoints, collect other users' waste and deliver them to recycling plants!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    fontSize: 20,
                  )),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Includes Regular's features",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'SFProText',
                      fontSize: 18,
                      color: Color.fromARGB(120, 0, 0, 0))),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          SvgPicture.asset(
            'assets/artwork/ecollector-art-register.svg',
            semanticsLabel: 'Ecollector Artwork',
            width: size.width,
          ),
          Expanded(
            child: Container(
              color: Color(0xFF5A5A5A),
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Button1(
                      btnData: ButtonData(
                    'BECOME AN ECOLLECTOR',
                    () {
                      //TODO: CONVERTIRLO EN ECOLLECTOR CON API
                    },
                    backgroundColor: BROWN_DARK,
                  )),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/tutorial');
                    },
                    child: Text('WATCH TUTORIAL',
                        style: TextStyle(
                          color: GREEN_LIGHT,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
