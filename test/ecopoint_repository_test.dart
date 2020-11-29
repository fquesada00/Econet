import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/services/ecopoint_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Ecopoint should be created', (){
    MyUser user = MyUser.complete("agustintormakh", "agustormakh@gmail.com", "11740590", "hola", true);
    
    final ecopoint = Ecopoint(user, false,[Residue.paper, Residue.glass], null, null, null, null, null, null, null);

    final repository = FirebaseEcopointProvider();

    repository.createEcopoint(ecopoint);

  });
}