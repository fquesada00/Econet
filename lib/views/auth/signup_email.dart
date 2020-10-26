import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/button_data.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SignupEmail extends StatefulWidget {
  @override
  _SignupEmailState createState() => _SignupEmailState();
}

class _SignupEmailState extends State<SignupEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          NavBar(
            text: 'Sign Up',
            withBack: true,
            backgroundColor: Colors.white,
            textColor: GREEN_MEDIUM,
            height: 120,
          ),
          Expanded(child: _EmailRegisterForm()),
        ],
      ),
    );
  }
}

class _FieldTemplateData {
  final String labelText;
  final Icon icon;

  _FieldTemplateData({@required this.labelText, this.icon});
}

class _EmailRegisterForm extends StatefulWidget {
  @override
  __EmailRegisterFormState createState() => __EmailRegisterFormState();
}

class __EmailRegisterFormState extends State<_EmailRegisterForm> {
  List<_FieldTemplateData> fieldData = [
    _FieldTemplateData(labelText: 'First Name', icon: Icon(Icons.person)),
    _FieldTemplateData(labelText: 'Last Name', icon: Icon(Icons.person)),
    _FieldTemplateData(labelText: 'Email Address', icon: Icon(Icons.email)),
    _FieldTemplateData(labelText: 'Password', icon: Icon(Icons.lock)),
  ];

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: fieldData
                .map((field) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 10.0),
                      child: TextFormField(
                        obscureText:
                            (field.labelText.toLowerCase() == 'password')
                                ? !_passwordVisible
                                : false,
                        decoration: InputDecoration(
                          labelText: field.labelText,
                          labelStyle: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontSize: 20,
                          ),
                          suffixIcon:
                              field.labelText.toLowerCase() == 'password'
                                  ? IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      })
                                  : null,
                          icon: field.icon,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
        SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "By continuing, you agree to Econet's ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Terms & Conditions',
                            style: TextStyle(color: GREEN_DARK)),
                        TextSpan(text: ' and '),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: GREEN_DARK)),
                      ]))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 45, right: 45, bottom: 30),
          child: Button1(
              btnData: ButtonData(
                  text: 'SIGN UP',
                  color: GREEN_MEDIUM,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print('FORM: OK');
                      Navigator.pushNamed(context, '/ecollector_or_regular');
                    }
                  })),
        ),
      ],
    );
  }
}
