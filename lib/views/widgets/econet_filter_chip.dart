import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class EconetFilterChip extends StatefulWidget {
  final String chipName;
  final Color chipColor;
  bool isSelected;
  Function(String chipName) selectChip;

  EconetFilterChip(this.chipName, this.chipColor, this.isSelected, this.selectChip);

  @override
  _EconetFilterChipState createState() => _EconetFilterChipState();
}

class _EconetFilterChipState extends State<EconetFilterChip> {
  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        label: Text(
          widget.chipName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: textColor,
          ),
        ),
        selected: widget.isSelected,
        backgroundColor: widget.chipColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        pressElevation: 0,
        onSelected: (isSelected) {
          setState(() {
            widget.isSelected = isSelected;
            widget.selectChip(widget.chipName);
          });
        },
        selectedColor: widget.chipName == 'Recycling Plants Only'
            ? TinyColor(widget.chipColor).brighten(50).color
            : TinyColor(widget.chipColor).brighten(15).color);
  }
}
