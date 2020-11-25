import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/presentation/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EcollectorOrRegular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          NavBar(
            text: 'Choose type of user',
            withBack: true,
            backgroundColor: Colors.white,
            textColor: GREEN_MEDIUM,
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _BuildEcollector(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: _BuildRegular(),
          ),
        ],
      ),
    );
  }
}

class _BuildEcollector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/tutorial');
        },
        child: Container(
          width: 309,
          height: 270,
          color: GREEN_LIGHT,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Ecollector',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 34,
                    color: GREEN_DARK,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Collect other users' waste and deliver them to recycling plants",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  "Includes Regular's features",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/artwork/ecollector-art-register.svg',
                semanticsLabel: 'Ecollector Artwork',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildRegular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/tutorial');
        },
        child: Container(
          width: 309,
          height: 270,
          color: BROWN_MEDIUM,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 0),
                child: Text(
                  'Regular',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 34,
                    color: Color(0xFF816946),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  "Deliver your waste to your nearest EcoPoint and let the Ecollector do the magic",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/artwork/regular-art-register.svg',
                semanticsLabel: 'Ecollector Artwork',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
