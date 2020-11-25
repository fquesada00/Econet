import 'package:econet/model/bag.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/model/user.dart';

class EcopointDelivery {
  String _ecopointId;
  DateTime _date;
  List<Bag> _bags;
  User _user;
  bool _isConfirmed; // Si el Ecollector respondio o no
  bool
      _responseValue; // La respuesta del Ecollector (acepta=true, rechaza=false)
}
