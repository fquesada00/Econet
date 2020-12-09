import 'dart:convert';

import 'package:econet/model/bag.dart';
import 'package:econet/model/residue.dart';

import 'my_user.dart';

class EcopointDelivery {
  String _ecopointId;
  DateTime _date;
  List<Bag> _bags;
  MyUser _user;
  bool _isConfirmed; // Si el Ecollector respondio o no
  bool
      _responseValue; // La respuesta del Ecollector (acepta=true, rechaza=false)

  EcopointDelivery(ecopointId, date, bags, user, isConfirmed, response) {
    _ecopointId = ecopointId;
    _date = date;
    _bags = bags;
    _user = user;
    _isConfirmed = isConfirmed;
    _responseValue = response;
  }

  factory EcopointDelivery.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);

    return EcopointDelivery(json['ecopointId'], json['date'], json['bags'],
        json['user'], json['isConfirmed'], json['response']);
  }

  String toJson() {
    return jsonEncode(<String, dynamic>{
      'ecopointId': _ecopointId,
      'date': _date,
      'bags': _bags,
      'user': _user,
      'isConfirmed': _isConfirmed,
      'response': _responseValue
    });
  }

  String get ecopointId => _ecopointId;

  DateTime get date => _date;

  List<Bag> get bags => _bags;

  MyUser get user => _user;

  bool get isConfirmed => _isConfirmed;

  bool get responseValue => _responseValue;
}
