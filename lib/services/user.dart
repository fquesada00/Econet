import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserApi{
  static String token;

  Future<void> firebaseEmailLogin(String email, String password) async {
    if(email == null || password == null){
      print("ALGUNO DE LOS CAMPOS ESTA  VACIO");
      return -1;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      token = await userCredential.user.getIdToken();
      print("TOKEN ====" + token);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> firebaseLogout() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> getUserProfile(String email,String token) async {
    final response = await http.get(
        "https://us-central1-econet-8552d.cloudfunctions.net/user?email=${email}",
        headers: {'Authorization': 'Bearer $token',}
    );
    print("HTTPS RESPONSE = " + response.body);
  }

  Future<void> updateUserProfile(String email,String token,User user) async {
    final response = await http.put(
      "https://us-central1-econet-8552d.cloudfunctions.net/user?email=${email}",
      headers: {'Authorization': 'Bearer $token',},
      body:user.toJSON();
      //body: {'userType':"ecollector",'lastName':"TERMEKH"},
    );
    print("HTTPS RESPONSE = " + response.body);
  }

  Future<void> deleteUserProfile(String email,String token) async {
    final response = await http.delete(
        "https://us-central1-econet-8552d.cloudfunctions.net/user?email=${email}",
        headers: {'Authorization': 'Bearer $token',}
    );
    print("HTTPS RESPONSE = " + response.body);
  }

}

class User{
  String email;

  toJSON() {
    return {'userType':"ecollector",'lastName':"TERMEKH"};
  }
}