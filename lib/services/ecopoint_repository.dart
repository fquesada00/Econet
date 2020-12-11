import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class EcopointProvider implements ChangeNotifier {
  Future<Ecopoint> getEcopoint(String ecopointId);
  Future<List<Ecopoint>> getEcopointsByRadius(
      double radius, double lat, double long);
  Future<List<Ecopoint>> getEcopointsByMaterials(List<String> materials);
  Future<List<Ecopoint>> getEcopointsByUser(String email);
  Future createEcopoint(Ecopoint ecopoint);
  Future updateEcopoint(Ecopoint ecopoint);
}

class FirebaseEcopointProvider extends EcopointProvider with ChangeNotifier {
  String _ecopointUrl =
      "https://us-central1-econet-8552d.cloudfunctions.net/ecopoint";

  FirebaseEcopointProvider() {}

  @override
  Future<bool> createEcopoint(Ecopoint ecopoint) async {
    if (ecopoint == null) {
      print("ECOPOINT ES NULL");
      return false;
    } else {
      try {
        final user = await getCurrentUser();
        final token = await user.getIdToken();
        final response = await http.post(
          _ecopointUrl + "?email=" + user.email.trim(),
          body: jsonEncode(ecopoint),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        print("RESPONSE = " + response.body.toString());
        return response.statusCode == 200;
      } catch (e) {
        return false; // TODO ver si podemos manejar mejor el error
      }
    }
  }

  @override
  Future<Ecopoint> getEcopoint(String ecopointId) async {
    final user = await getCurrentUser();
    final token = await user.getIdToken();
    final response = await http.get(
      _ecopointUrl +
          "?email=" +
          user.email.trim() +
          "&ecopointId=" +
          ecopointId,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("RESPONSE ================ " + response.body.toString());
    //  print("RESPONSE ================ " + Ecopoint.fromJson(jsonDecode(response.body)).toString());
    return Ecopoint.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<Ecopoint>> getEcopointsByMaterials(List<String> materials) async {
    final user = await getCurrentUser();
    final token = await user.getIdToken();
    // String materialsString = materials.reduce((value,material) =>value+ 'materials='+ material)
    String materialsString = '?';
    materials.forEach((element) {
      materialsString += 'materials=' + element + '&';
    });
    materialsString.substring(0, materialsString.length - 1);
    final response = await http.get(
      _ecopointUrl + materialsString,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("RESPONSE ================ " + response.body.toString());

    List ecopointsDoc = jsonDecode(response.body) as List;
    return ecopointsDoc.map((e) => Ecopoint.fromJson(e)).toList();
  }

  @override
  Future<List<Ecopoint>> getEcopointsByRadius(
      double radius, double lat, double long) async {
    final user = await getCurrentUser();
    final token = await user.getIdToken();
    print(token);
    final response = await http.get(
      _ecopointUrl +
          '?radius=' +
          radius.toString() +
          '&latitude=' +
          lat.toString() +
          '&longitude=' +
          long.toString(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("RESPONSE ================ " + response.body.toString());
    List ecopointsDoc = jsonDecode(response.body) as List;
    return ecopointsDoc.map((e) => Ecopoint.fromJson(e)).toList();
  }

  @override
  Future<List<Ecopoint>> getEcopointsByUser(String email) async {
    final user = await getCurrentUser();
    final token = await user.getIdToken();
    final response = await http.get(
      _ecopointUrl + "?email=" + user.email.trim(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    List ecopointsDoc = jsonDecode(response.body) as List;
    return ecopointsDoc.map((e) => Ecopoint.fromJson(e)).toList();
  }

  @override
  Future updateEcopoint(Ecopoint ecopoint) async {
    final user = await getCurrentUser();
    final token = await user.getIdToken();
    final response = await http.put(
      _ecopointUrl +
          "?email=" +
          user.email.trim() +
          "&ecopointId=" +
          ecopoint.id,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("RESPONSE ================ " + response.body.toString());
    return Ecopoint.fromJson(jsonDecode(response.body));
  }

  Future<User> getCurrentUser() async {
    final user = await FirebaseAuth.instance.currentUser;

    return user;
    // final idToken = await user.getIdToken();

    // Create authorization header
    // final header = { "authorization": 'Bearer $token' };
  }
}
