import 'package:econet/model/timeslot.dart';
import 'package:flutter/material.dart';


class CreateEcopointModel{

  //Makes singleton
  CreateEcopointModel._privateConstructor();

  static final CreateEcopointModel instance = CreateEcopointModel._privateConstructor();


  /* Tal vez vamos a usar esto despues
  User ecollector;
  bool isPlant;
  List<Residue> residues;
  String plantId;
  DateTime deadline;
  //List<TimeSlot> openHours;
  String additionalInfo;
  LatLng coordinates;
*/
  String name;
  String address;
  List<String> selectedResidues;
  DateTime deliveryDate;
  TimeOfDay deliveryTime;
  List<TimeSlot> timeslotsWeekdays = List();
  List<DateTime> chosenWeekdays = List();
  List<bool>
  
  addTimeslot(int day,int fromHour, int fromMinute, int toHour,int toMinute){
    if(timeslotsWeekdays[day] == null){
      timeslotsWeekdays[day] = new TimeSlot(day);
    }
    final from = fromHour.toString().padLeft(2, '0') + ":" + fromMinute.toString().padLeft(2, '0');
    final to = toHour.toString().padLeft(2, '0') + ":" + toMinute.toString().padLeft(2, '0');
    timeslotsWeekdays[day].addRange(from,to);

  }

  List getRangesOfDay(int day) {
    day = day%6;
    print("getRangesOfDays length");
    print(timeslotsWeekdays.length);
    print(day);
    if (timeslotsWeekdays.length > 0) {
      if (timeslotsWeekdays[day] == null){
        return List(0);
      } else {
        return timeslotsWeekdays[day].ranges;
      }
    }else{
      return List(0);
    }
  }

  removeTimeslot(int day,TimeSlot timeslot){
    //Doesn't seem to be implemented yet in class timeslot.dart
  }


  reset(){
    selectedResidues = null;
    name = null;
    address = null;
    selectedResidues = null;
    deliveryDate = null;
    deliveryTime = null;
    timeslotsWeekdays = List();
    chosenWeekdays = List();

    //do this for every relevant fieldd
  }
}
