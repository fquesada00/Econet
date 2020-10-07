
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email,password;
  TextEditingController emailTextController = TextEditingController(),passwordTextController=TextEditingController();

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
              )
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
      String token = await userCredential.user.getIdToken();
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
  }
}
