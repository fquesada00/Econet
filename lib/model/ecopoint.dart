import 'dart:convert';

import 'package:econet/model/timeslot.dart';
import 'package:econet/model/residue.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'my_user.dart';

class Ecopoint {
  String _id;
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
      this._id,
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

  String toJSON() {
    return json.encode({
      'latitude': this._coordinates.latitude,
      'longitude': this._coordinates.longitude,
      'isPlant': this._isPlant,
      'openHours': this._openHours.toString(),
      'deadline': this._deadline.toString(),
      'address': this._address,
      'residues': this._residues.toString()
    });
  }

  double getLatitude() {
    return this._coordinates.latitude;
  }

  double getLongitude() {
    return this._coordinates.longitude;
  }
}
