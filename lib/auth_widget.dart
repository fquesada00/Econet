import 'package:econet/app.dart';
import 'package:econet/services/user.dart';
import 'package:econet/views/auth/login_or_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      child: StreamBuilder<User>(
          stream: auth.onAuthStateChanged(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            print(
                "---------------------------------------------------//AUTH WIDGET STATE CHANGED//------------------------------");
            if (snap.connectionState == ConnectionState.active) {
              final user = snap.data;
              return user == null ? LoginOrSignup() : MyHomePage();
            }
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
