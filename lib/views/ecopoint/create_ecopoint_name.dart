import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEcopointName extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: NavBar(
        text: 'Choose a name for your Ecopoint',
        textColor: GREEN_DARK,
        withBack: true,
        backgroundColor: GREEN_LIGHT,
      ),
      backgroundColor: GREEN_LIGHT,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Hero(
                  tag: 'EcopointInput',
                  child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      controller: _controller,
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
                        if (value.trim().isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.27),
            Hero(
              tag: 'ContinueButton',
              child: Button1(
                btnData: ButtonData('CONTINUE', () {
                  if (_formKey.currentState.validate()) {
                    CreateEcopointModel.instance.name = _controller.text;
                    Navigator.pushNamed(context, '/ecopoint_overview');
                  }
                }, backgroundColor: GREEN_DARK),
              ),
            )
          ],
        ),
      ),
    );
  }
}
