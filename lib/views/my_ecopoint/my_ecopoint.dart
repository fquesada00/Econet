import 'package:econet/model/ecopoint.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/tab_slide_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_ecopoint_details_tab.dart';
import 'my_ecopoint_pending_tab.dart';
import 'my_ecopoint_requests_tab.dart';

class MyEcopoint extends StatelessWidget {
  String residueName = "Cardboard";
  final List<String> tabNames = ["Details", "Pending", "Requests"];

  @override
  Widget build(BuildContext context) {
    final Ecopoint ecopoint = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: BROWN_LIGHT,
      body: Column(
        children: <Widget>[
          NavBar(
            text: residueName,
            withBack: true,
            backgroundColor: Colors.transparent,
            textColor: BROWN_DARK,
            rightIcon: Icons.delete_forever,
            onPressedRightIcon: () {
              //TODO: ABRIR DIALOGO PARA CONFIRMAR DELETE
            },
          ),
          Expanded(
            child: DefaultTabController(
              length: tabNames.length,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(26),
                    child: TabSlideChoose(tabNames, BROWN_MEDIUM, BROWN_DARK),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        MyEcopointDetailsTab(ecopoint),
                        MyEcopointPendingTab(ecopoint),
                        MyEcopointRequestsTab(ecopoint)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
