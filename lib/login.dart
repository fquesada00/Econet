
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email,password;
  TextEditingController emailTextController = TextEditingController(),passwordTextController=TextEditingController();
  bool isLoggedIn = false;
  String token;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Center(
          child: Column(
            children: [
              TextField(
                controller: emailTextController,
              ),
              Container(child: Text("password"),),
              TextField(
                controller: passwordTextController,
              ),
              RaisedButton(
                child: Text("LOGIN"),
                onPressed: (){
                  firebaseEmailLogin(emailTextController.text,passwordTextController.text);
                },
              ),
              RaisedButton(
                child: Text('LOGOUT'),
                onPressed: (){
                  firebaseLogout();
                },
              ),
              isLoggedIn && token!= null? RaisedButton(
                child: Text('Get USER PROFILE'),
                onPressed: (){
                  email = emailTextController.text;
                  getUserProfile(email, token);
                },
              )
                  :
              Container(),
              isLoggedIn && token!= null? RaisedButton(
                child: Text('UPDATE USER PROFILE'),
                onPressed: (){
                  email = emailTextController.text;
                  updateUserProfile(email, token);
                },
              )
                  :
              Container(),
            ],
          ),
        ),
      ),
    );
  }

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
      setState(() {
        isLoggedIn=true;
      });

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
    await FirebaseAuth.instance.signOut();
    setState(() {
      isLoggedIn=false;
    });
  }
}

Future<void> getUserProfile(String email,String token) async {
  final response = await http.get(
      "https://us-central1-econet-8552d.cloudfunctions.net/user?email=${email}",
      headers: {'Authorization': 'Bearer $token',}
  );
  print("HTTPS RESPONSE = " + response.body);
}

Future<void> updateUserProfile(String email,String token) async {
  final response = await http.put(
      "https://us-central1-econet-8552d.cloudfunctions.net/user?email=${email}",
      headers: {'Authorization': 'Bearer $token',},
      body: {'userType':"ecollector",'lastName':"TERMEKH"},
  );
  print("HTTPS RESPONSE = " + response.body);
}
