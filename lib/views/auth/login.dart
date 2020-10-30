import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/presentation/custom_icons_icons.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            NavBar(
              text: 'Log In',
              withBack: true,
              backgroundColor: Colors.white,
              textColor: BROWN_MEDIUM,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _LoginForm(),
            ),
          ],
        ));
  }
}

class _LoginForm extends StatefulWidget {
  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  List<_LoginServiceData> services = [
    _LoginServiceData(color: Colors.black, icon: CustomIcons.apple),
    _LoginServiceData(color: Color(0xFF4285F4), icon: CustomIcons.google),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 35, right: 35, bottom: 20, top: 50),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 20,
                    ),
                    icon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Field is required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, top: 8.0),
                child: TextFormField(
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 20,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        }),
                    icon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Field is required';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: BROWN_DARK,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: services
                .map((service) => _LoginServiceButton(data: service))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Button1(
              btnData: ButtonData(
            'LOG IN',
            () {
              if (_formKey.currentState.validate()) {
                print('FORM: OK');
              }
            },
            backgroundColor: BROWN_MEDIUM,
          )),
        ),
      ],
    );
  }
}

class _LoginServiceData {
  Color color;
  IconData icon;

  _LoginServiceData({this.color, this.icon});
}

class _LoginServiceButton extends StatelessWidget {
  final _LoginServiceData data;

  _LoginServiceButton({this.data});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      highlightElevation: 0,
      color: data.color,
      textColor: Colors.white,
      onPressed: () => null,
      child: Icon(data.icon, size: 35),
      padding: EdgeInsets.all(13),
      shape: CircleBorder(),
    );
  }
}
