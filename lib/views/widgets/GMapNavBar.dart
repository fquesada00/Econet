import 'package:econet/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'SearchDialog.dart';

class GMapNavBar extends StatelessWidget implements PreferredSizeWidget {
  final bool withBack;
  final Color backgroundColor;
  final Color textColor;
  final BuildContext context;
  final bool searchingFlag;
  final Function switchSearchState;
  static String searchText = '';
  static TextEditingController _controller = TextEditingController();

  const GMapNavBar(
      {Key key,
      this.withBack,
      this.searchingFlag,
      this.switchSearchState,
      this.backgroundColor,
      this.textColor,
      this.context})
      : super(key: key);

  void changeSearchText(String text) {
    searchText = text;
  }

  @override
  Widget build(BuildContext context) {
    // Border radius de la search bar
    final BorderRadius _BORDER_RADIUS = BorderRadius.circular(60);
    if (!searchingFlag)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MaterialButton(
                        elevation: 5,
                        color: GREEN_MEDIUM,
                        textColor: Colors.white,
                        onPressed: () {
                          print(Scaffold.of(context).isDrawerOpen);
                          Scaffold.of(context).openDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                        ),
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        borderRadius: _BORDER_RADIUS,
                        child: GestureDetector(
                          onTap: () async {
                            switchSearchState();
                            // mientras esta abierto el dialog esta "buscando"
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  SearchDialog(_controller),
                            );
                            // cuando se cierra el popup, vuelven a aparecer los widgets del mapa
                            switchSearchState();
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: _BORDER_RADIUS,
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.search,
                                    size: 25,
                                  ),
                                ),
                                Text(
                                  (_controller.text == '')
                                      ? "Search locations, filters"
                                      : _controller.text,
                                  style: TextStyle(
                                    fontFamily: 'SFProDisplay',
                                    fontSize: 17,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: MaterialButton(
                        elevation: 5,
                        //color: (Scaffold.of(context).isDrawerOpen) ? Colors.white : BROWN_MEDIUM,
                        //textColor: (Scaffold.of(context).isDrawerOpen) ? BROWN_MEDIUM : Colors.white,
                        color: BROWN_MEDIUM,
                        textColor: Colors.white,
                        onPressed: () => null,
                        child: Icon(
                          Icons.notifications,
                        ),
                        padding: EdgeInsets.all(10),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    else
      return Container(
        color: Colors.transparent,
      );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(75);
}
