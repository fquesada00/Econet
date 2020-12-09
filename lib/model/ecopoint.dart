import 'dart:convert';

import 'package:econet/model/timeslot.dart';
import 'package:econet/model/residue.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'my_user.dart';

class Ecopoint {
  String id;
  MyUser _ecollector;
  bool _isPlant;
  List<Residue> _residues;
  String _plantId;
  DateTime _deadline;
  List<TimeSlot> _openHours;
  String _additionalInfo;
  String _name;
  String _address;
  LatLng _coordinates;

  Ecopoint(
      this._ecollector,
      this._isPlant,
      this._residues,
      this._plantId,
      this._deadline,
      this._openHours,
      this._additionalInfo,
      this._name,
      this._address,
      this._coordinates);

  Ecopoint.fromFirebase(
      this.id,
      this._ecollector,
      this._isPlant,
      this._residues,
      this._plantId,
      this._deadline,
      this._openHours,
      this._additionalInfo,
      this._name,
      this._address,
      this._coordinates);
  Ecopoint.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this._plantId = map['plantId'];
    this._ecollector = MyUser.fromJson(map['user']);
    this._isPlant = map['isPlant'];

    List<dynamic> residues = map['residues'];
    this._residues = residues.map((e) => residueFromString(e)).toList();
    this._deadline = DateTime.parse(map['deadline']);
    List<dynamic> timeslots = map['openHours'];
    this._openHours = timeslots.map((e) => TimeSlot.fromJson(e)).toList();
    // this._additionalInfo,
    // this._name,
    this._address = map['address'];
    // Map<String, dynamic> coords = map['coordinates'];

    this._coordinates = LatLng(map['coordinates']['geopoint']['_latitude'],
        map['coordinates']['geopoint']['_longitude']);
  }
  Map<String, dynamic> toJson() {
    return {
      'latitude': this._coordinates.latitude,
      'longitude': this._coordinates.longitude,
      'isPlant': this._isPlant,
      'openHours': this._openHours,
      'deadline': this._deadline.toString(),
      'address': this._address,
      'residues': this._residues.map((e) => residueToString(e)).toList(),
      'plantId': this._plantId ?? "no-plant",
    };
  }

  double getLatitude() {
    return this._coordinates.latitude;
  }

  double getLongitude() {
    return this._coordinates.longitude;
  }

  LatLng get coordinates => _coordinates;

  String get address => _address;

  String get name => _name;

  String get additionalInfo => _additionalInfo;

  List<TimeSlot> get openHours => _openHours;

  DateTime get deadline => _deadline;

  String get plantId => _plantId;

  List<Residue> get residues => _residues;

  bool get isPlant => _isPlant;

  MyUser get ecollector => _ecollector;
}
