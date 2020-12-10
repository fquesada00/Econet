import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';

class CreateAdditionalDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        text: 'Additional details (optional)',
        withBack: true,
        backgroundColor: BROWN_LIGHT,
      ),
      backgroundColor: BROWN_LIGHT,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Use this field to specify any additional information other users may need when delivering to your Ecopoint',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: BROWN_DARK,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 12,
                maxLines: 12,
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
                  hintText: 'Insert additional details',
                  hintStyle: TextStyle(
                    fontFamily: 'SFProText',
                    fontSize: 18,
                  ),
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            SizedBox(height: 50),
            Button1(
              btnData: ButtonData('CONTINUE', () {
                // TODO: MANDARLO AL VIEWMODEL y PASAR A CHOOSE NAME
              }, backgroundColor: BROWN_MEDIUM),
            )
          ],
        ),
      ),
    );
  }
}
