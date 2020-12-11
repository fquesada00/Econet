import 'package:econet/model/my_user.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/cache.dart';
import 'package:econet/services/user.dart';
import 'package:econet/views/GMap/GMap.dart';
import 'package:econet/views/faq/faq_list.dart';
import 'package:econet/views/my_recycling/my_recycling.dart';
import 'package:econet/views/tutorials/tutorials.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _drawerPos;
  bool _isLoading;
  bool _isEcollector;

  Widget _getHomeContent(int pos) {
    switch (pos) {
      case 0:
        return GMap();
      case 1:
        return MyRecycling();
      case 2:
        return Tutorials();
      case 3:
        return FAQList();
      default:
        return GMap();
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _drawerPos = 0;
    saveUserToCache();
  }

  Future<void> saveUserToCache() async {
    MyUser user = await Provider.of<AuthProvider>(context, listen: false)
        .getCurrentUser();
    Cache.write('user', {'isEcollector': user.isEcollector});
    _isEcollector =
        await Cache.read('user').then((value) => value['isEcollector']);
    _isLoading = false;
    setState(() {});
  }

  Widget _getAppBar(int pos) {
    switch (pos) {
      case 1:
        return NavBar(
          text: 'My Recycling',
          textColor: GREEN_DARK,
          withDrawer: true,
          backgroundColor: Colors.white,
        );
      case 3:
        return NavBar(
          text: 'Frequently Asked Questions',
          textColor: GREEN_DARK,
          withDrawer: true,
          backgroundColor: Colors.white,
        );
      default:
        return NavBar(
          text: '',
          height: 0,
          backgroundColor: Colors.transparent,
          textColor: Colors.transparent,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: _drawerPos == 0,
      backgroundColor: Colors.white,
      appBar: _isLoading ? _getAppBar(0) : _getAppBar(_drawerPos),
      drawer: AppDrawer(
          (pos) => setState(() {
                Navigator.of(context).pop();
                _drawerPos = pos;
              }),
          _drawerPos,
          _isEcollector),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _getHomeContent(_drawerPos),
    );
  }
}
