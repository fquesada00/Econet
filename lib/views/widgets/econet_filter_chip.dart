import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class EconetFilterChip extends StatefulWidget {
  final String chipName;
  final Color chipColor;

  EconetFilterChip(this.chipName, this.chipColor);

  @override
  _EconetFilterChipState createState() => _EconetFilterChipState();
}

class _EconetFilterChipState extends State<EconetFilterChip> {
  bool _isSelected = false;
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
        selected: _isSelected,
        backgroundColor: widget.chipColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        pressElevation: 0,
        onSelected: (isSelected) {
          setState(() {
            // TODO: Filter implementation
            _isSelected = isSelected;
          });
        },
        selectedColor: widget.chipName == 'Recycling Plants Only'
            ? TinyColor(widget.chipColor).brighten(50).color
            : TinyColor(widget.chipColor).brighten(15).color);
  }
}
