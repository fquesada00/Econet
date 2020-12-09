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

  Map<String, dynamic> toJson(){
    return {
      'firstHour': this.first.hour,
      'firstMinute': this.first.minute,
      'lastHour': this.last.hour,
      'lastMinute': this.last.minute,
    };
  }

  TimeRange.fromJson(Map<String, dynamic> map){
    this.first = TimeOfDay(hour: map['firstHour'], minute: map['firstMinute']);
    this.last = TimeOfDay(hour: map['lastHour'], minute: map['lastMinute']);
  }
}