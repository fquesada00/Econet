import 'dart:io';

import 'package:flutter/material.dart';

import 'package:econet/model/timerange.dart';

class TimeSlot implements Comparable<TimeSlot> {
  List<TimeRange> ranges;
  int weekDay;
  int overlapPos;

  TimeSlot(int weekDay) {
    this.weekDay = weekDay;
    this.ranges = List();
  }

  Future<void> okBtn() async {
    sleep(Duration(seconds: 5));
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

  @override
  int compareTo(TimeSlot other) {
    return weekDay - other.weekDay;
  }

  @override
  String toString() {
    return "WeekDay ${weekDay} with time slots: " + ranges.toString();
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
}
