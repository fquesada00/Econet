import 'package:flutter/material.dart';

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
    return "${first.hour}:${first.minute}-${last.hour}:${last.minute}";
  }
}