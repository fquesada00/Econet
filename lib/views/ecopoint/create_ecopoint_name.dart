import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEcopointName extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: NavBar(
        text: 'Additional details (optional)',
        withBack: true,
        backgroundColor: GREEN_LIGHT,
      ),
      backgroundColor: GREEN_LIGHT,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SFProText',
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Insert Ecopoint name',
                    hintStyle: TextStyle(
                      fontFamily: 'SFProText',
                      fontSize: 18,
                    ),
                    errorStyle:
                        TextStyle(fontFamily: 'SFProText', fontSize: 16),
                    contentPadding: EdgeInsets.all(20),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Field is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: size.height * 0.25),
            Button1(
              btnData: ButtonData('CONTINUE', () {
                if (_formKey.currentState.validate()) {
                  // TODO: MANDARLO AL VIEWMODEL y PASAR A OVERVIEW
                  // Navigator.pushNamed(context, '/GMap');
                }
              }, backgroundColor: GREEN_DARK),
            )
          ],
        ),
      ),
    );
  }
}
