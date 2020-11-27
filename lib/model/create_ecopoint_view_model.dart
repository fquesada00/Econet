import 'package:econet/model/timeslot.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/model/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CreateEcopoint{ //Make singleton

  static final CreateEcopoint _CreateEcopoint = CreateEcopoint._internal();

  factory CreateEcopoint(
    _ecollector,
    _isPlant,
    _residues,
    _plantId,
    _deadline,
    _openHours,
    _additionalInfo,
    _name,
    _address,
    _coordinates) {

      return _CreateEcopoint ?? CreateEcopoint._internal(_ecollector, _isPlant, _residues, _plantId, _deadline, _openHours, _additionalInfo, _name, _address, _coordinates);
    }

  CreateEcopoint._internal(
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
  List<List> timeslotsWeedays = List.c;


}
