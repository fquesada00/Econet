import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabSlideChoose extends StatefulWidget {
  final ValueChanged<int> selection;
  final List<String> names;
  final Color backgroundColor;
  final Color foregroundColor;

  TabSlideChoose(
      this.selection, this.names, this.backgroundColor, this.foregroundColor);

  @override
  _TabSlideChooseState createState() => _TabSlideChooseState();
}

class _TabSlideChooseState extends State<TabSlideChoose> {
  int _selected = 0;
  List<Tab> rows = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TabBar(
        unselectedLabelColor: widget.backgroundColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: widget.foregroundColor,
        ),
        tabs: _tabs(widget.names),
        onTap: (value) {
          setState(() {
            _selected = value;
            widget.selection(value);
          });
        },
      ),
    );
  }

  List<Tab> _tabs(List<String> names) {
    rows.clear();
    for(int i = 0; i < names.length ; i++){
      rows.add(
        Tab(
          child: Container(
            padding: EdgeInsets.all(14.0),
            child: Text(
              names[i],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SFProText',
                  color: (_selected == i)
                      ? Colors.white
                      : Colors.black54),
            ),
          ),
        ),
      );
    }
    return rows;
  }
}
