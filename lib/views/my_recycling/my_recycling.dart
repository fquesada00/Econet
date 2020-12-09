import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:econet/views/widgets/tab_slide_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_recycling_deliveries_tab.dart';
import 'my_recycling_ecopoints_tab.dart';

class MyRecycling extends StatelessWidget {
  final List<String> tabNames = ["My Deliveries", "My Ecopoints"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.white,
            child: DefaultTabController(
              length: tabNames.length,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 26, right: 26),
                    child: TabSlideChoose(
                        tabNames, Colors.grey.withOpacity(0.5), GREEN_DARK),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        MyRecyclingDeliveriesTab(),
                        MyRecyclingEcopointsTab()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
