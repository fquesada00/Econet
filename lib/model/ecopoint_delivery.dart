import 'dart:convert';

import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint.dart';

import 'my_user.dart';

class EcopointDelivery {
  Ecopoint _ecopoint;
  MyUser _user;
  DateTime _date;
  List<Bag> _bags;
  bool _isConfirmed; // Si el Ecollector respondio o no
  bool _finished;
  bool
      _responseValue; // La respuesta del Ecollector (acepta=true, rechaza=false)

  EcopointDelivery(
      ecopoint, date, bags, user, isConfirmed, response, finished) {
    _ecopoint = ecopoint;
    _date = date;
    _bags = bags;
    _user = user;
    _isConfirmed = isConfirmed;
    _finished = finished;
    _responseValue = response;
  }

  EcopointDelivery.fromJson(Map<String,dynamic> json) {
    _ecopoint = Ecopoint.fromJson(json['ecopoint']);
    _date = DateTime.parse(json['date']);
    _bags = (json['bags'] as List).map((e) => Bag.fromJson(e)).toList();
    _user = MyUser.fromJson(json['user']);
    _isConfirmed = json['isConfirmed'];
    _finished = json['finished'];
    _responseValue = json['response'];
  }


  Map<String, dynamic> toJson(){
    return {
      'ecopoint': _ecopoint.toJson(),
      'date': _date.toString(),
      'bags': bags,
      'user': _user.toJson(),
      'isConfirmed': _isConfirmed,
      'response': _responseValue,
      'finished': _finished
    };
  }

  Ecopoint get ecopoint => _ecopoint;

  DateTime get date => _date;

  List<Bag> get bags => _bags;

  MyUser get user => _user;

  bool get isConfirmed => _isConfirmed;

  bool get finished => _finished;

  bool get responseValue => _responseValue;
}
