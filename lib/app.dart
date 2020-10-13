import 'package:econet/views/GMap/Ecopoint.dart';
import 'package:econet/views/auth/login_or_signup.dart';
import 'package:econet/views/auth/signup_method.dart';
import 'package:econet/views/profile/ecollector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:econet/views/GMap/GMap.dart';



// Para convertir el color de la app en un Material Color y poder definirlo como default

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Econet is flying high'),
        '/loginsignup': (context) => LoginOrSignup(),
        '/signup_method': (context) => SignUpMethod(),
        '/GMap': (context) => GMap(),
        '/Ecollector': (context) => Ecollector(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFA3CB8F, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: MaterialColor(
            0xFFA3CB8F, color), // el navigation drawer toma este color de fondo
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Ecopoint> ecopoints;
  bool ecopointAvailable = false;

  void _incrementCounter() async {
    ecopoints = (await getEcopoints(343, 343, 432)).cast<Ecopoint>();
    if (ecopoints != null && ecopoints.length != 0) {
      setState(() {
        ecopointAvailable = true;
        _counter++;
      });
    } else {
      setState(() {
        ecopointAvailable = false;
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Widget para variar las configuraciones del status bar entre las views
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '##Para testing##',
            ),
            RaisedButton(
              child: Text("maps"),
              onPressed: () {
                Navigator.pushNamed(context, '/GMap');
              },
            ),
            RaisedButton(
              child: Text('Login screen'),
              onPressed: () {
                Navigator.pushNamed(context, '/loginsignup');
              },
            ),
            RaisedButton(
              child: Text('profile'),
              onPressed: () {
                Navigator.pushNamed(context, '/Ecollector');
              },
            ),
            ecopointAvailable
                ? SafeArea(
              child: ListView.builder(
                itemCount: ecopoints.length,
                itemBuilder: (context, index) {
                  Ecopoint aux = ecopoints[index];
                  return ListTile(
                    title: Text('${aux.latitude},${aux.longitude}'),
                  );
                },
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}


