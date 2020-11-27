abstract class EcopointProvider{
  Future getEcopoint(String ecopointId);
  Future<List> getEcopointsByRadius(double radius, double lat, double long);
  Future<List> getEcopointsByMaterials(List<String> materials);
  Future<List> getEcopointsByUser(String email);
  Future createEcopoint(Ecopoint ecopoint);

}