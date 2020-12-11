import 'package:econet/model/residue.dart';
import 'package:econet/model/timerange.dart';
import 'package:econet/model/timeslot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ecopoint.dart';

class CreateEcopointModel {
  //Makes singleton
  CreateEcopointModel._privateConstructor();

  static final CreateEcopointModel _instance =
      CreateEcopointModel._privateConstructor();

  static CreateEcopointModel get instance => _instance;

  /* Tal vez vamos a usar esto despues
  User ecollector;
  bool isPlant;
  List<Residue> residues;
  String plantId;
  DateTime deadline;
  //List<TimeSlot> openHours;
  String additionalInfo;
*/
  String name;
  String address;
  LatLng coordinates;
  List<Residue> selectedResidues;
  Ecopoint plant;
  DateTime deliveryDate;
  TimeOfDay deliveryTime;
  List<TimeSlot> timeslotsWeekdays;
  List<DateTime> chosenWeekdays = List();
  String additionalInfo;

  void initializeTimeSlots() {
    // print('im in initializetimeslot');
    // print('${timeslotsWeekdays.toString()}');
    // if (timeslotsWeekdays != null) {
    //   print('ya hay timeslots');
    //   return;
    // }
    timeslotsWeekdays = List();
    for (int i = 0; i < 7; i++) {
      timeslotsWeekdays.add(TimeSlot(i));
      // print('printing timeslot + $i');
      // print('${timeslotsWeekdays[i]}');
    }
  }

  List<bool> addTimeslot(
      int day, int fromHour, int fromMinute, int toHour, int toMinute) {
    // if(timeslotsWeekdays == null) initializeTimeSlots();
    // if (timeslotsWeekdays[day] == null) {
    //   timeslotsWeekdays[day] = new TimeSlot(day);
    // }
    final from = fromHour.toString().padLeft(2, '0') +
        ":" +
        fromMinute.toString().padLeft(2, '0');
    final to = toHour.toString().padLeft(2, '0') +
        ":" +
        toMinute.toString().padLeft(2, '0');
    print('day ${timeslotsWeekdays.length}');
    print('from ${from} to ${to}');
    timeslotsWeekdays[day].addRange(from, to);
  }

  List<TimeRange> getRangesOfDay(int day) {
    // day = day % 6;
    // return timeslotsWeekdays[day].ranges;
    if (timeslotsWeekdays.length > 0) {
      if (timeslotsWeekdays[day] == null) {
        return List();
      } else {
        return timeslotsWeekdays[day].ranges;
      }
    } else {
      return List();
    }
  }

  removeTimeslot(int day, int index) {
    timeslotsWeekdays[day].removeRange(index: index);
    //Doesn't seem to be implemented yet in class timeslot.dart
  }

  reset() {
    selectedResidues = null;
    name = null;
    address = null;
    coordinates = null;
    selectedResidues = null;
    deliveryDate = null;
    deliveryTime = null;
    timeslotsWeekdays = List<TimeSlot>();
    chosenWeekdays = List<DateTime>();
    plant = null;

    //do this for every relevant fieldd
  }
}
