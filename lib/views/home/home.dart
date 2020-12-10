import 'package:econet/presentation/constants.dart';
import 'package:econet/views/GMap/GMap.dart';
import 'package:econet/views/my_recycling/my_recycling.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _drawerPos;

  Widget _getHomeContent(int pos) {
    switch (pos) {
      case 0:
        return GMap();
      case 1:
        return MyRecycling();
      default:
        return GMap();
    }
  }

  @override
  void initState() {
    super.initState();
    _drawerPos = 0;
  }

  Widget _getAppBar(int pos) {
    switch (pos) {
      case 0:
        return NavBar(
          text: '',
          height: 0,
          backgroundColor: Colors.transparent,
          textColor: Colors.transparent,
        );
      case 1:
        return NavBar(
          text: 'My Recycling',
          textColor: GREEN_DARK,
          withDrawer: true,
          backgroundColor: Colors.white,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: _drawerPos == 0,
      appBar: _getAppBar(_drawerPos),
      drawer: AppDrawer(
          (pos) => setState(() {
                Navigator.of(context).pop();
                _drawerPos = pos;
              }),
          _drawerPos),
      body: _getHomeContent(_drawerPos),
    );
  }
}
