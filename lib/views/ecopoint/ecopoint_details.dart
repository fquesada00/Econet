import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/model/timeslot.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/EconetButton.dart';
import 'package:econet/views/widgets/ecopoint_info_list.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EcopointDetails extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Ecopoint ecopoint = ModalRoute.of(context).settings.arguments;

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
                    child: EconetButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ecopoint_expanded',
                            arguments: ecopoint);
                      },
                      backgroundColor: GREEN_DARK,
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
