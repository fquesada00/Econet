import 'package:flutter/material.dart';

import 'Pair.dart';

//TODO DEBERIA TENER EL MES
class TimeSlot {

  List<Pair<TimeOfDay, TimeOfDay>> ranges;
  int weekDay;

  TimeSlot(int weekDay){
    this.weekDay = weekDay;
    this.ranges = List();
  }

  //rango recibido es valido
  void addRange(String from, String to){
      int firstHour = int.parse(from.substring(0, 1));
      int firstMinutes = int.parse(from.substring(3,4));
      int secondHour = int.parse(to.substring(0,1));
      int secondMinutes = int.parse(to.substring(3,4));
      ranges.add(Pair(TimeOfDay(hour: firstHour, minute: firstMinutes), TimeOfDay(hour: secondHour, minute: secondMinutes)));
  }

  List<Pair<TimeOfDay, TimeOfDay>> getRanges(){
    return ranges;
  }

  int getDay(){
    return weekDay;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlot &&
          runtimeType == other.runtimeType &&
          ranges == other.ranges &&
          weekDay == other.weekDay;

  @override
  int get hashCode => ranges.hashCode ^ weekDay.hashCode;
}