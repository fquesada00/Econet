import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget _createDrawerItem({String text, bool active, GestureTapCallback onTap}) {
  return ListTile(
    title: Container(
      alignment: Alignment.centerLeft,
      height: 40,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontFamily: 'SFProDisplayBold',
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: (active) ? Colors.white : null,
          borderRadius: BorderRadius.circular(90)),
    ),
    onTap: onTap,
  );
}


class AppDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => DrawerState();
}

class DrawerState extends State<AppDrawer> {
  var states = [true, false, false, false, false, false];  // Home es el que corre primero

  void changeState(index){
    for(int i = 0; i < states.length; i++)
      states[i] = false;

    states[index] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(0, 130, 0, 0),
        children: <Widget>[

          _createDrawerItem(text: 'Home', active: states[0], onTap: (){setState((){changeState(0);});}),
          _createDrawerItem(text: 'My recycling', active: states[1], onTap: (){setState((){changeState(1);});}),
          _createDrawerItem(text: 'News', active: states[2], onTap: (){setState((){changeState(2);});}),
          _createDrawerItem(text: 'Tutorials', active: states[3], onTap: (){setState((){changeState(3);});}),
          _createDrawerItem(text: 'FAQs', active: states[4], onTap: (){setState((){changeState(4);});}),
          _createDrawerItem(text: 'Profile', active: states[5], onTap: (){setState((){changeState(5);});}),

          // No lo pude mandar con la funcion por que tiene icono, distinto tamanio, color y font
          ListTile(
            title: GestureDetector(
              onTap: () {}, //IMPLEMENTAR
              child: Container(
                height: 40,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.remove_red_eye, // agregar icono reciclaje
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Become an ecollector',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'SFProDisplaySemiBold',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFB3816E),
                    borderRadius: BorderRadius.circular(90)),
              ),
            ),
          ),

          Divider(
            indent: 40,
            endIndent: 40,
            color: Colors.black,
            thickness: 2.5,
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'SFProDisplay',
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text(
              'Help',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'SFProDisplay',
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
