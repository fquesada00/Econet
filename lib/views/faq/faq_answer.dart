import 'package:econet/presentation/constants.dart';
import 'package:econet/views/faq/qa.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';

class FAQAnswer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QA qa = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: NavBar(
        text: '',
        backgroundColor: Colors.white,
        withBack: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                child: Text(qa.question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: GREEN_DARK,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
              ),
            ),
          ),
          Expanded(
              child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: GREEN_MEDIUM,
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Text(qa.answer,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'SFProText',
                              fontWeight: FontWeight.w600)),
                    ),
                  )))
        ],
      ),
    );
  }
}
