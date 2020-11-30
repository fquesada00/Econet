import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  Future createEcopoint(Ecopoint ecopoint) async {
    if (ecopoint == null) {
      print("ECOPOINT ES NULL");
      //TODO: verificar campos dentro de la clase
    } else {
      try {
        print("DEBUG:Empezamos");
        final user = await getCurrentUser();
        final token = await user.getIdToken();
        print("DEBUG: Antes del request");
        final response = await http.post(
          _ecopointUrl + "?email=" + user.email,
          body: ecopoint.toJSON(),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        print("RESPONSE = " + response.toString());
        print("DEBUG: Despues del request " + ecopoint.toJSON());
      } catch (e) {
        print(e.toString()); // TODO ver si podemos manejar mejor el error
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
        'Authorization': 'Bearer $token',
      },
    );
    print("RESPONSE ================ " + response.toString());
  }

  @override
  Future<List<Ecopoint>> getEcopointsByMaterials(List<String> materials) {
    // TODO: implement getEcopointsByMaterials
    throw UnimplementedError();
  }

  @override
  Future<List<Ecopoint>> getEcopointsByRadius(
      double radius, double lat, double long) {
    // TODO: implement getEcopointsByRadius
    throw UnimplementedError();
  }

  @override
  Future<List<Ecopoint>> getEcopointsByUser(String email) {
    // TODO: implement getEcopointsByUser
    throw UnimplementedError();
  }

  @override
  Future updateEcopoint(Ecopoint ecopoint) {
    // TODO: implement updateEcopoint
    throw UnimplementedError();
  }

  Future<User> getCurrentUser() async {
    final user = await FirebaseAuth.instance.currentUser;

    return user;
    // final idToken = await user.getIdToken();

    // Create authorization header
    // final header = { "authorization": 'Bearer $token' };
  }
}
