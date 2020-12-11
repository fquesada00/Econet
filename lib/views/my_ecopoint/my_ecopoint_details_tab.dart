import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/model/timeslot.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/ecopoint_info_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyEcopointDetailsTab extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  Ecopoint ecopoint;
  MyEcopointDetailsTab(this.ecopoint);

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

    return SingleChildScrollView(
      child: Column(
        children: [
          Button1(
            btnData: ButtonData(
              'CONFIRM DELIVERY',
              // TODO: ABRIR DIALOGO PARA CONFIRMAR LA OPERACION
              () {},
              backgroundColor: GREEN_DARK,
            ),
          ),
          SizedBox(height: 25),
          EcopointInfoList(
              ecopoint, true, null, _nameController, _additionalInfoController),
        ],
      ),
    );
  }
}
