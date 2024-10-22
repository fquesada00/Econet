import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/services/user.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  String errorMessage = "";

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    List<_LoginServiceData> services = [
      _LoginServiceData(
          color: Color(0xFF4285F4),
          icon: CustomIcons.google,
          onPressed: () async {
            final credential = await auth.signInWithGoogle();
            Navigator.pushNamedAndRemoveUntil(
                context, '/home_econet', ModalRoute.withName('/'));
            // Navigator.popUntil(context, ModalRoute.withName('/'));
          }),
    ];
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontSize: 20,
                  ),
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
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  style: TextStyle(
                    fontSize: 20,
                  ),
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
        auth.onAuthStateChanged() != null
            ? Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Hero(
                  tag: 'LoginButton',
                  child: Button1(
                    btnData: ButtonData(
                      'LOG IN',
                      () async {
                        if (_formKey.currentState.validate()) {
                          signInWithEmailAndPassword(context);
                          // Navigator.pushNamed(context, '/GMap');
                        }
                      },
                      backgroundColor: BROWN_MEDIUM,
                    ),
                  ),
                ),
              )
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(GREEN_MEDIUM),
              ),
      ],
    );
  }

  signInWithEmailAndPassword(BuildContext context) async {
    errorMessage = await Provider.of<AuthProvider>(context, listen: false)
        .emailLogin(emailController.text, passwordController.text);
    print(errorMessage);
    if (errorMessage.trim() == "successfully logged in") {
      print("DID IT");
      Navigator.pushNamedAndRemoveUntil(
          context, '/home_econet', ModalRoute.withName('/'));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Incorrect user and/or password. Please try again.'),
      ));
      print("not equal");
    }
    setState(() {});
    print('FORM: OK');
  }

  signInWithGoogle(BuildContext context) async {
    final res = await Provider.of<AuthProvider>(context).signInWithGoogle();

    if (res != null) {
      print("DID IT");
      Navigator.popUntil(context, ModalRoute.withName('/auth'));
    } else {
      print("not equal");
    }
    setState(() {});
    print('FORM: OK');
  }
}

class _LoginServiceData {
  Color color;
  IconData icon;
  Function onPressed;

  _LoginServiceData({this.color, this.icon, this.onPressed});
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
      onPressed: () => data.onPressed.call(),
      child: Icon(data.icon, size: 35),
      padding: EdgeInsets.all(13),
      shape: CircleBorder(),
    );
  }
}
