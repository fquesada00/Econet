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

  static String getRemainingDeliverTime(DateTime from) {
    int aux;

    aux = from.difference(DateTime.now()).inDays;
    if (aux != 0) return aux.toString() + " days";

    aux = from.difference(DateTime.now()).inHours;
    if (aux != 0) return aux.toString() + " hours";

    aux = from.difference(DateTime.now()).inMinutes;
    return aux.toString() + " minutes";
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