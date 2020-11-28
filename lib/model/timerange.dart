import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class TimeRange implements Comparable<TimeRange>{
  TimeOfDay first;
  TimeOfDay last;

  TimeRange({this.first, this.last});

  @override
  int compareTo(TimeRange other) {
    return (first.hour*100+first.minute) - (other.first.hour*100 + other.first.minute);
  }

  @override
  String toString() {
    return sprintf("%02d:%02d-%02d:%02d", [first.hour, first.minute, last.hour, last.minute]);  //formato HH:MM
  }
}