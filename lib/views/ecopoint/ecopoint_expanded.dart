import 'package:econet/model/create_delivery_view_model.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/econet_display_chip.dart';
import 'package:econet/views/widgets/ecopoint_info_list.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EcopointExpanded extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _additionalInfoController =
  TextEditingController();
  final CreateDeliveryModel viewModel = CreateDeliveryModel.instance;

  @override
  Widget build(BuildContext context) {
    Ecopoint ecopoint = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GREEN_LIGHT,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: NavBar(
              text: ecopoint.name,
              withBack: true,
              backgroundColor: GREEN_LIGHT,
              textColor: GREEN_DARK,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: EcopointInfoList(
                  ecopoint,
                  false,
                  SizedBox(
                    height: 60,
                    width: 220,
                    child:
                    Button1(
                      btnData: ButtonData(
                        'RECYCLE',
                            () {
                          viewModel.reset();
                          viewModel.ecopoint = ecopoint;
                          Navigator.pushNamed(context, '/add_bags');
                          //TODO: DEBERIA MANDARLO A ARRANCAR A ARMAR DELIVERY
                        },
                        backgroundColor: GREEN_DARK,
                        fontSize: 24,
                        svgUrl: 'assets/icons/econet-circle.svg',
                        adjust: true,
                        width: 200,
                        height: 50,
                      ),
                    ),
                  ),
                  _nameController,
                  _additionalInfoController),
            ),
          ),
        ],
      ),
    );
  }
}

class EcollectorCard extends StatelessWidget {
  MyUser _ecollector;

  EcollectorCard(this._ecollector);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 180,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: GREEN_DARK,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Container(
        height: 180,
        width: 170,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('ECOLLECTOR',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: GREEN_LIGHT)),
            CircleAvatar(radius: 45, backgroundColor: Colors.white),
            Text(
              _ecollector.fullName != null ? _ecollector.fullName : '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoCardContainer extends StatelessWidget {
  final Widget content;
  final String header;
  final IconData icon;

  InfoCardContainer({this.content, this.header, this.icon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              header,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: GREEN_DARK,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (icon != null)
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      bottom: 20,
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                    ),
                  ),
                ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 20),
                  child: content,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
