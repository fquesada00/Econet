import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/tab_slide_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_ecopoint_details_tab.dart';
import 'my_ecopoint_pending_tab.dart';
import 'my_ecopoint_requests_tab.dart';

class MyEcopoint extends StatelessWidget {
  int selected = 0;
  String residueName = "Cardboard";
  final List<String> tabNames = ["Details", "Pending", "Requests"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: BROWN_LIGHT,
      body: Column(
        children: <Widget>[
          NavBar(
            text: residueName,
            withBack: true,
            backgroundColor: Colors.transparent,
            textColor: BROWN_DARK,
          ),
          Expanded(
            child: DefaultTabController(
              length: tabNames.length,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 26, right: 26, top: 26),
                    child: TabSlideChoose(
                      //funcion que guarda cual se encuentra seleccionado
                            (int newSelected) {
                          selected = newSelected;
                        }, tabNames, BROWN_MEDIUM, BROWN_DARK),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        MyEcopointDetailsTab(),
                        MyEcopointPendingTab(),
                        MyEcopointRequestsTab()
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