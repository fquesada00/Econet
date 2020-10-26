import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:econet/views/widgets/searchFilters.dart';

class FilterTesting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: SearchFilters()),
    );
  }
}
