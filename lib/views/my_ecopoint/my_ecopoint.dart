import 'package:econet/model/ecopoint.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/ecopoint_repository.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/tab_slide_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_ecopoint_details_tab.dart';
import 'my_ecopoint_pending_tab.dart';
import 'my_ecopoint_requests_tab.dart';

class MyEcopoint extends StatelessWidget {
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
            text: ecopoint.name,
            withBack: true,
            backgroundColor: Colors.transparent,
            textColor: BROWN_DARK,
            rightIcon: Icons.delete_forever,
            onPressedRightIcon: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text("CONFIRM DELETE"),
                        content: Text("You cant undo this action"),
                        actions: [
                          FlatButton(
                            onPressed: () async {
                              EcopointProvider ecopointRepository =
                                  Provider.of<EcopointProvider>(context,
                                      listen: false);
                              await ecopointRepository
                                  .deleteEcopoint(ecopoint.id);
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/home_econet',
                                  ModalRoute.withName('/landing'));
                            },
                            child: Text("Confirm"),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Cancel"),
                          ),
                        ],
                      ));
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
