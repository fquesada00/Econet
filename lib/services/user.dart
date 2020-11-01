import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class UserApi {
  static String token;

  Future<void> firebaseLogout() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> getUserProfile(String email, String token) async {
    final response = await http.get(
        "https://us-central1-econet-8552d.cloudfunctions.net/user?email=${email}",
        headers: {
          'Authorization': 'Bearer $token',
        });
    print("HTTPS RESPONSE = " + response.body);
  }

  Future<void> updateUserProfile(String email, String token, User user) async {
    final response = await http.put(
      "https://us-central1-econet-8552d.cloudfunctions.net/user?email=${email}",
      headers: {
        'Authorization': 'Bearer $token',
      },
      //body:user.toJSON()
      //body: {'userType':"ecollector",'lastName':"TERMEKH"},
    );
    print("HTTPS RESPONSE = " + response.body);
  }

  Future<void> deleteUserProfile(String email, String token) async {
    final response = await http.delete(
        "https://us-central1-econet-8552d.cloudfunctions.net/user?email=${email}",
        headers: {
          'Authorization': 'Bearer $token',
        });
    print("HTTPS RESPONSE = " + response.body);
  }
}

class MyUser {
  String userId;
  String name, email, type, token;
  Future<String> tokenFuture;

  MyUser(
      {this.userId,
      this.name,
      this.email,
      this.type,
      this.token,
      this.tokenFuture}) {
    getUserToken();
  }

  getUserToken() async {
    if (this.tokenFuture != null) {
      this.token = await this.tokenFuture;
    }
  }

  factory MyUser.fromJson(Map<String, dynamic> map) {
    return MyUser(
      userId: map['id'] ?? 1,
      name: map['name'] ?? "beto",
      email: map['email'] ?? "beto@gmail.com",
      type: map['type'] ?? "regular",
      token: map['token'] ?? 0,
    );
  }

  toJSON() {
    return {'userType': "ecollector", 'lastName': "TERMEKH"};
  }
}

class AppUrl {
  static const String baseUrl =
      "https://us-central1-econet-8552d.cloudfunctions.net";
  static const String userUrl = baseUrl + "/user";
}

enum AuthStatus {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
}

abstract class AuthProvider implements ChangeNotifier {
  Stream<MyUser> onAuthStateChanged();
  Future<String> emailLogin(String email, String password);
  Future<String> registerWithEmailAndPassword(String email, String password);
  Future<void> loginWithGoogle();
  logOut();
}

class FirebaseAuthProvider with ChangeNotifier implements AuthProvider {
  AuthStatus _loggedInStatus = AuthStatus.NotLoggedIn;
  AuthStatus _registeredStatus = AuthStatus.NotRegistered;

  AuthStatus get loggedInStatus => _loggedInStatus;
  AuthStatus get registeredStatus => _registeredStatus;
  String _token;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  MyUser _userFromFirebase(User firebaseUser) {
    print("FIREBASE USER ===== " + firebaseUser.toString());
    return firebaseUser == null
        ? null
        : MyUser(
            email: firebaseUser.email,
            userId: firebaseUser.uid,
            tokenFuture: firebaseUser.getIdToken());
  }

  @override
  Stream<MyUser> onAuthStateChanged() {
    return _firebaseAuth
        .authStateChanges()
        .map((user) => _userFromFirebase(user));
  }

  @override
  Future<String> emailLogin(String email, String password) async {
    if (email == null || password == null) {
      print("ALGUNO DE LOS CAMPOS ESTA VACIO");
      if (email == null) {
        return "email is empty";
      } else {
        return "password is empty";
      }
    }
    try {
      _loggedInStatus = AuthStatus.Authenticating;
      notifyListeners();
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      _token = await userCredential.user.getIdToken();
      _loggedInStatus = AuthStatus.LoggedIn;
      notifyListeners();
      //print("TOKEN ====" + _token);
      return "successfully logged in";
    } on FirebaseAuthException catch (e) {
      _loggedInStatus = AuthStatus.NotLoggedIn;
      notifyListeners();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.code;
    }
  }

  @override
  Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    if (email == null || password == null) {
      print("ALGUNO DE LOS CAMPOS ESTA  VACIO");
      if (email == null) {
        return "email is empty";
      } else {
        return "password is empty";
      }
    }
    try {
      // _registeredStatus = AuthStatus.Registering;
      // notifyListeners();
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print("HOLIS");
      _token = await userCredential.user.getIdToken();
      _loggedInStatus = AuthStatus.LoggedIn;
      // notifyListeners();
      // print("TOKEN ====" + _token);
      return "successfully logged in";
    } on FirebaseAuthException catch (e) {
      print("HOLIS 2");
      // _loggedInStatus = AuthStatus.NotLoggedIn;
      // notifyListeners();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e);
      }
      return e.code;
    }
  }

  @override
  Future<void> logOut() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<void> loginWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
