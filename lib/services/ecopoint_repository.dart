import 'package:econet/model/ecopoint.dart';
import 'package:econet/services/user.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class EcopointProvider{
  Future<Ecopoint> getEcopoint(String ecopointId);
  Future<List<Ecopoint>> getEcopointsByRadius(double radius, double lat, double long);
  Future<List<Ecopoint>> getEcopointsByMaterials(List<String> materials);
  Future<List<Ecopoint>> getEcopointsByUser(String email);
  Future createEcopoint(Ecopoint ecopoint);
  Future updateEcopoint(Ecopoint ecopoint);
}

class FirebaseEcopointProvider implements EcopointProvider{

  FirebaseEcopointProvider(MyUser userProvider){

  }

  @override
  Future createEcopoint(Ecopoint ecopoint) {
    // TODO: implement createEcopoint
    throw UnimplementedError();
  }

  @override
  Future<Ecopoint> getEcopoint(String ecopointId) {
    // TODO: implement getEcopoint
    throw UnimplementedError();
  }

  @override
  Future<List<Ecopoint>> getEcopointsByMaterials(List<String> materials) {
    // TODO: implement getEcopointsByMaterials
    throw UnimplementedError();
  }

  @override
  Future<List<Ecopoint>> getEcopointsByRadius(double radius, double lat, double long) {
    // TODO: implement getEcopointsByRadius
    throw UnimplementedError();
  }

  @override
  Future<List<Ecopoint>> getEcopointsByUser(String email) {
    // TODO: implement getEcopointsByUser
    throw UnimplementedError();
  }

  @override
  Future updateEcopoint(Ecopoint ecopoint
      ) {
    // TODO: implement updateEcopoint
    throw UnimplementedError();
  }

}