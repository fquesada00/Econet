import 'package:econet/model/TimeSlot.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/model/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Ecopoint {
  String _id;
  User _ecollector;
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
}
