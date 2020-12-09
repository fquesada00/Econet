import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EconetDisplayChip extends StatefulWidget {
  final String chipName;
  final Color chipColor;

  EconetDisplayChip(this.chipName, this.chipColor);

  @override
  _EconetDisplayChipState createState() => _EconetDisplayChipState();
}

class _EconetDisplayChipState extends State<EconetDisplayChip> {
  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Text(
          widget.chipName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: textColor,
          ),
        ),
        backgroundColor: widget.chipColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ));
  }
}
