import 'package:econet/model/ecopoint.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/ecopoint_info_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEcopointDetailsTab extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  Ecopoint ecopoint;
  MyEcopointDetailsTab(this.ecopoint);

  @override
  Widget build(BuildContext context) {
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
              ecopoint, true, null, _nameController, _additionalInfoController, editable: false,),
        ],
      ),
    );
  }
}
