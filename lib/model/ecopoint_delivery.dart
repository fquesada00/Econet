import 'dart:convert';

import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint.dart';

import 'my_user.dart';

class EcopointDelivery {
  Ecopoint _ecopoint;
  MyUser _user;
  DateTime _date;
  List<Bag> _bags;
  bool isConfirmed; // Si el Ecollector respondio o no
  bool finished;
  bool
      responseValue; // La respuesta del Ecollector (acepta=true, rechaza=false)
  String _id;

  EcopointDelivery(
      ecopoint, date, bags, user, isConfirmed, response, finished) {
    _ecopoint = ecopoint;
    _date = date;
    _bags = bags;
    _user = user;
    isConfirmed = isConfirmed;
    finished = finished;
    responseValue = response;
  }

  EcopointDelivery.fromJson(Map<String, dynamic> json) {
    _ecopoint = Ecopoint.fromJson(json['ecopoint']);
    _date = DateTime.parse(json['date']);
    _bags = (json['bags'] as List).map((e) => Bag.fromJson(e)).toList();
    _user = MyUser.fromJson(json['user']);
    isConfirmed = json['isConfirmed'];
    finished = json['finished'];
    responseValue = json['response'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ecopoint': _ecopoint.toJson(),
      'ecopointId': _ecopoint.id,
      'date': _date.toString(),
      'bags': bags,
      'user': _user.toJson(),
      'isConfirmed': isConfirmed,
      'response': responseValue,
      'finished': finished,
      'id': _id
    };
  }

  Ecopoint get ecopoint => _ecopoint;

  DateTime get date => _date;

  List<Bag> get bags => _bags;

  MyUser get user => _user;

  String get id => _id;
}
