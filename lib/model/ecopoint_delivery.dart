import 'package:econet/model/bag.dart';
import 'package:econet/model/user.dart';

class EcopointDelivery {
  String _ecopointId;
  DateTime _date;
  List<Bag> _bags;
  User _user;
  bool _isConfirmed; // Si el Ecollector respondio o no
  bool
      _responseValue; // La respuesta del Ecollector (acepta=true, rechaza=false)

  EcopointDelivery(this._ecopointId, this._date, this._bags, this._user);

  String get ecopointId => _ecopointId;

  DateTime get date => _date;

  List<Bag> get bags => _bags;

  User get user => _user;

  bool get isConfirmed => _isConfirmed;

  bool get responseValue => _responseValue;
}
