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
  List<TimeSlot> _timeslotsWeekdays = List.filled(7, null, growable: false);
  List<bool> chosenWeekdays = List.filled(7, false, growable: false);
  List<bool>
  
  addTimeslot(int day,int fromHour, int fromMinute, int toHour,int toMinute){
    chosenWeekdays[day] = true;
    if(_timeslotsWeekdays[day] == null){
      _timeslotsWeekdays[day] = new TimeSlot(day);
    }
    final from = fromHour.toString().padLeft(2, '0') + ":" + fromMinute.toString().padLeft(2, '0');
    final to = toHour.toString().padLeft(2, '0') + ":" + toMinute.toString().padLeft(2, '0');
    _timeslotsWeekdays[day].addRange(from,to);

  }

  List getRangesOfDay(int day) {
    if (_timeslotsWeekdays[day] == null) {
      return List(0);
    } else {
      return _timeslotsWeekdays[day].ranges;
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
    _timeslotsWeekdays = List.filled(7, null, growable: false);
    chosenWeekdays = List.filled(7, false, growable: false);

    //do this for every relevant fieldd
  }
}
