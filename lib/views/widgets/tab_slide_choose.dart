import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabSlideChoose extends StatefulWidget {
  final List<String> names;
  final Color backgroundColor;
  final Color foregroundColor;

  TabSlideChoose(this.names, this.backgroundColor, this.foregroundColor);

  @override
  _TabSlideChooseState createState() => _TabSlideChooseState();
}

class _TabSlideChooseState extends State<TabSlideChoose> {
  List<Tab> rows = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: TabBar(
        unselectedLabelColor: Colors.black54,
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: widget.foregroundColor,
        ),
        tabs: _tabs(widget.names),
      ),
    );
  }

  List<Tab> _tabs(List<String> names) {
    rows.clear();
    for (int i = 0; i < names.length; i++) {
      rows.add(Tab(
        child: Container(
          child: Text(
            names[i],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'SFProText',
            ),
          ),
        ),
      ));
    }
    return rows;
  }
}
