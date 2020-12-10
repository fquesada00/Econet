import 'dart:io';

import 'package:flutter/material.dart';

import 'package:econet/model/timerange.dart';

class TimeSlot implements Comparable<TimeSlot> {
  List<TimeRange> ranges = List();
  int weekDay;
  int overlapPos;

  TimeSlot(int weekDay) {
    this.weekDay = weekDay;
  }

  Future<void> okBtn() async {
    //sleep(Duration(seconds: 5));
    return;
  }

  //rango recibido es valido
  void addRange(String from, String to) async {
    if (overlap(from, to)) {
      await okBtn();
      print("Repetead range at pos ${overlapPos}");
      return;
    }
    int firstHour = int.parse(from.substring(0, 2));
    int firstMinutes = int.parse(from.substring(3, 5));
    int secondHour = int.parse(to.substring(0, 2));
    int secondMinutes = int.parse(to.substring(3, 5));
    ranges.add(TimeRange(
        first: TimeOfDay(hour: firstHour, minute: firstMinutes),
        last: TimeOfDay(hour: secondHour, minute: secondMinutes)));
    ranges.sort();
  }

  void removeRange({int index,TimeRange timerange}){
    if(index != null) {
      try {
        ranges.removeAt(index);
        print("Removed timerange at index " + index.toString() + ranges.toString());
      } on RangeError {
        print(
            "The index:" +index.toString() +  " you're trying to remove in timeslot.dart does not exist");
      }
    }else if(timerange != null){
      try {
        ranges.remove(timerange);
      } on RangeError {
        print(
            "The timerange you're trying to remove in timeslot.dart does not exist");
      }
    }
  }

  @override
  int compareTo(TimeSlot other) {
    return weekDay - other.weekDay;
  }

  @override
  String toString() {
    return "WeekDay ${weekDay} with time slots: " + ranges.toString();
  }

  //funcion usada en my_ecopoint_details_tab
  String toStringDay() {
    String weekDayName;
    switch (weekDay) {
      case 0:
        weekDayName = "Monday";
        break;
      case 1:
        weekDayName = "Tuesday";
        break;
      case 2:
        weekDayName = "Wednesday";
        break;
      case 3:
        weekDayName = "Thursday";
        break;
      case 4:
        weekDayName = "Friday";
        break;
      case 5:
        weekDayName = "Saturday";
        break;
      case 6:
        weekDayName = "Sunday";
    }
    return "$weekDayName";
  }

  //funcion usada en my_ecopoint_details_tab
  String toStringRanges() {
    String aux = "";
    ranges.forEach((element) {
      aux += element.toString() + " ";
    });
    return "$aux";
  }

  bool overlap(String from, String to) {
    int firstHour = int.parse(from.substring(0, 2));
    int firstMinutes = int.parse(from.substring(3, 5));
    int secondHour = int.parse(to.substring(0, 2));
    int secondMinutes = int.parse(to.substring(3, 5));
    bool flag = false;

    for (int i = 0; i < ranges.length; i++) {
      if (isBetween(
              ranges[i].first.hour * 100 + ranges[i].first.minute,
              ranges[i].last.hour * 100 + ranges[i].last.minute,
              firstHour * 100 + firstMinutes) ||
          isBetween(
              ranges[i].first.hour * 100 + ranges[i].first.minute,
              ranges[i].last.hour * 100 + ranges[i].last.minute,
              secondHour * 100 + secondMinutes)) {
        flag = true;
        overlapPos = i + 1; // imprimir a la hora de hacer display
        break;
      }
    }
    return flag;
    //
    // ranges.forEach((element) {
    //   if (isBetween(
    //           element.first.hour * 100 + element.first.minute,
    //           element.last.hour * 100 + element.last.minute,
    //           firstHour * 100 + firstMinutes) ||
    //       isBetween(
    //           element.first.hour * 100 + element.first.minute,
    //           element.last.hour * 100 + element.last.minute,
    //           secondHour * 100 + secondMinutes)) {
    //     print(
    //         "${isBetween(element.first.hour * 100 + element.first.minute, element.last.hour * 100 + element.last.minute, firstHour * 100 + firstMinutes)}");
    //     flag = true;
    //     overlapPos = ranges.indexOf(element);
    //   }
    // });
    // return flag;
  }

  bool isBetween(int infRange, int topRange, int value) {
    print(
        "${infRange} to ${topRange} with ${value} result: ${infRange <= value && topRange >= value}");
    return infRange <= value && topRange >= value;
  }

  Map<String, dynamic> toJson(){
    return {
      'ranges':this.ranges,
      'weekday': this.weekDay,
      'overlapPos': this.overlapPos,
    };
  }

  TimeSlot.fromJson(Map<String, dynamic> map){
    List<dynamic> rgs = map['ranges'];
    this.ranges = rgs.map((e) => TimeRange.fromJson(e)).toList();
    this.weekDay = map['weekday'];
    this.overlapPos = map['overlapPos'];
  }
}
