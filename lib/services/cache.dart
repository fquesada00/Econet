import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class Cache{

  static String _basePath;
  static bool _initialized = true;
  static Map<String,ChangeNotifier> _notifiers;

  static initialize() async {
    if(_initialized) {
      _basePath = (await getApplicationDocumentsDirectory()).path + '/';
      _notifiers = new Map();
      _initialized = false;
    }
  }

  static Future write(String dir,Map<String,dynamic> data) async {
    await initialize();
    File file = new File(_basePath + dir);
    await file.writeAsString(jsonEncode(data));
    if(_notifiers.containsKey(dir)){
      _notifiers[dir].notifyListeners();
    }
  }

  static Future<Map<String, dynamic>> read(String dir) async{
    await initialize();
    File file = new File(_basePath + dir);
    return jsonDecode(await (file.readAsString()));
  }

  static Future addListener(String dir, listener) async {
    await initialize();
    if(!_notifiers.containsKey(dir)){
      _notifiers[dir] = new ChangeNotifier();
    }
    _notifiers[dir].addListener(listener);
  }

  static Future removeListener(String dir, Function listener ) async {
    await initialize();
    if(_notifiers.containsKey(dir)){
      _notifiers.remove(dir);
    }
  }



}