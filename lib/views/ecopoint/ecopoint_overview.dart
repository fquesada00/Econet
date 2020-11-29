import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/model/timeslot.dart';
import 'package:econet/model/user.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/accept_reject_bottom.dart';
import 'package:econet/views/widgets/ecopoint_info_list.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EcopointOveriew extends StatelessWidget {
  Ecopoint ecopoint = new Ecopoint(
      new User("jerusa jerusalinsky", "", "", "0303456", true),
      false,
      [Residue.glass, Residue.electronics, Residue.paper, Residue.metal],
      "",
      DateTime.now(),
      [],
      "pere perere perepperep",
      "nombre xd",
      "calle Falsa 123",
      new LatLng(0, 0)); //TODO: CONEXION A API

  @override
  Widget build(BuildContext context) {
    //BORRAR LO SIGUIENTE CUANDO SE HAGA LA CONEXION A API
    TimeSlot aux = new TimeSlot(3);
    aux.addRange('09:00', '11:00');
    aux.addRange('16:00', '19:00');
    ecopoint.openHours.add(aux);
    aux = TimeSlot(6);
    aux.addRange('13:00', '17:00');
    ecopoint.openHours.add(aux);
    //----------------------------------------------------

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GREEN_LIGHT,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: NavBar(
              text: 'Ecopoint overview',
              withBack: true,
              backgroundColor: GREEN_LIGHT,
              textColor: GREEN_DARK,
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100),  //tamanio del widget inferior
                  child: EcopointInfoList(ecopoint),
                ),
                Positioned(
                  bottom: 0,
                  child: AcceptOrRejectBottom("Confirm", "Discard", () {
                    print("hmhm");
                  }, () {
                    print("hmhmn't");
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
