import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/searchFilters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  final TextEditingController _controller;
  final List<String> filterElements;
  final Function(String chipName, bool add) updateFilterResidues;

  SearchDialog(
      this._controller, this.filterElements, this.updateFilterResidues);

  @override
  _SearchDialogState createState() => _SearchDialogState(_controller);
}

class _SearchDialogState extends State<SearchDialog> {
  TextEditingController _controller;

  _SearchDialogState(this._controller);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // para asegurarnos que cuando el teclado esta abierto
      // el usuario vea la busqueda
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            SearchBox(_controller),
            SizedBox(height: 15),
            SearchHistory(_controller),
            SizedBox(height: 15),
            SearchFilters(
              filterElements: widget.filterElements,
              updateFilterResidues: widget.updateFilterResidues,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatefulWidget {
  TextEditingController _controller;

  SearchBox(this._controller);

  @override
  _SearchBoxState createState() => _SearchBoxState(_controller);
}

class _SearchBoxState extends State<SearchBox> {
  final BorderRadius _BORDER_RADIUS = BorderRadius.circular(60);
  TextEditingController _controller;

  _SearchBoxState(this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 50,
      width: 340,
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
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Flexible(
            child: TextField(
              autofocus: true, // apenas se abre el layout se focusea el search
              controller: _controller,
              onSubmitted: (String s) {
                Navigator.of(context).pop();
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: _BORDER_RADIUS,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: _BORDER_RADIUS,
                ),
                hintText: "Search locations, filters",
                hintStyle: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchHistory extends StatefulWidget {
  TextEditingController _controller;

  SearchHistory(this._controller);

  @override
  _SearchHistoryState createState() => _SearchHistoryState(this._controller);
}

class _SearchHistoryState extends State<SearchHistory> {
  TextEditingController _controller;

  _SearchHistoryState(this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: 340,
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
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Recent searches',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: RECENT_SEARCHES_DATA
                .map(
                  (currentText) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        _controller.text = currentText;
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 290,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFE5E2E2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.history,
                                size: 30,
                              ),
                            ),
                            Text(
                              currentText,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontFamily: 'SFProText',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
