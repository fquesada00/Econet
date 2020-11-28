import 'package:econet/model/timeslot.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/model/user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CreateEcopointModel{

  //Makes singleton
  //static final CreateEcopointModel _createEcopointModel = CreateEcopointModel._internal();
  CreateEcopointModel._privateConstructor();

  static final CreateEcopointModel instance = CreateEcopointModel._privateConstructor();

  /*factory CreateEcopointModel() {

      return _createEcopointModel;
    }
  CreateEcopointModel._internal();*/


  User ecollector;
  bool isPlant;
  List<Residue> residues;
  String plantId;
  DateTime deadline;
  //List<TimeSlot> openHours;
  String additionalInfo;

  LatLng coordinates;

  String name;
  String address;
  List<String> selectedResidues;
  DateTime deliveryDate;
  TimeOfDay deliveryTime;
  List<TimeSlot> _timeslotsWeekdays = List.filled(7, null, growable: false);
  List<bool> availableWeekdays = List.filled(7, false, growable: false);
  
  addTimeslot(int day,String from, String to){
    availableWeekdays[day] = true;
    if(_timeslotsWeekdays[day] == null){
      _timeslotsWeekdays[day] = new TimeSlot(day);
    }else {
      _timeslotsWeekdays[day].addRange(from,to);
    }
  }
  getRangesOfDay(int day) {
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
    availableWeekdays = List.filled(7, false, growable: false);

    //do this for every relevant fieldd
  }
}
