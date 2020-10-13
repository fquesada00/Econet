import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/GMapNavBar.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ecollector extends StatefulWidget {
  @override
  _EcollectorState createState() => _EcollectorState();
}

class _EcollectorState extends State<Ecollector> {
  String name;

  _EcollectorState({this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: BROWN_DARK,
      drawer: AppDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        backgroundColor: BROWN_LIGHT,
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          SizedBox(
            width: 5.0,
          )
        ],
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Scaffold(
          backgroundColor: BROWN_LIGHT,
          body: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/woman-a.jpg'),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                  child: Text(
                    '$name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 10, 40.0, 0),
                child: Divider(
                  thickness: 5.0,
                  color: BROWN_MEDIUM,
                ),
              ),
              Container(
                child: Text('Acá va la información/datos del usuario'),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: () {},
                    color: BROWN_MEDIUM,
                    child: Text(
                      'My Ecopoints',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
            ],
          ),
        ),
      ),
    );
  }
}
