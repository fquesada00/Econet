import 'package:econet/presentation/constants.dart';
import 'package:econet/views/settings/settings_account_tab.dart';
import 'package:econet/views/settings/settings_app_tab.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/tab_slide_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final List<String> tabNames = ["App", "Account"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          NavBar(
            text: 'Settings',
            withBack: true,
            backgroundColor: Colors.white,
            textColor: GREEN_DARK,
          ),
          Expanded(
            child: DefaultTabController(
              length: tabNames.length,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 26, right: 26, top: 26),
                    child: TabSlideChoose(
                        tabNames, Colors.grey.withOpacity(0.5), GREEN_DARK),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        SettingsAppTab(),
                        SettingsAccountTab()
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
