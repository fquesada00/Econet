import 'dart:convert';

import 'package:econet/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

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
  Stream<User> onAuthStateChanged();
  Future<String> emailLogin(String email, String password);
  Future<String> registerWithEmailAndPassword(String email, String password);
  Future<UserCredential> signInWithGoogle();
  logOut();
  Future updateUser(MyUser user);
}

class FirebaseAuthProvider with ChangeNotifier implements AuthProvider {
  AuthStatus _loggedInStatus = AuthStatus.NotLoggedIn;
  AuthStatus _registeredStatus = AuthStatus.NotRegistered;

  AuthStatus get loggedInStatus => _loggedInStatus;
  AuthStatus get registeredStatus => _registeredStatus;
  String _token;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _userUrl = "https://us-central1-econet-8552d.cloudfunctions.net/user";

  // MyUser _userFromFirebase(User firebaseUser) {
  //   print("FIREBASE USER ===== " + firebaseUser.toString());
  //   return firebaseUser == null
  //       ? null
  //       : MyUser(
  //           firebaseUser.displayName,
  //           firebaseUser.email,
  //         );
  // }

  @override
  Stream<User> onAuthStateChanged() {
    return _firebaseAuth.authStateChanges()
        // .map((user) => _userFromFirebase(user)
        ;
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
    signOutWithGoogle();
    return await _firebaseAuth.signOut();
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
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

  @override
  Future<void> signOutWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signOut();
  }

  @override
  Future updateUser(MyUser user) async {
    if (user == null) {
      print("user ES NULL");
    } else {
      try {
        final currentUser = await getCurrentUser();
        final token = await currentUser.getIdToken();
        final response = await http.put(
          _userUrl + "?email=" + currentUser.email.trim(),
          body: jsonEncode(user),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        print("RESPONSE = " + response.body.toString());
      } catch (e) {
        print(e.toString()); // TODO ver si podemos manejar mejor el error
      }
    }
  }

  Future<User> getCurrentUser() async {
    final user = await FirebaseAuth.instance.currentUser;

    return user;
  }
}
