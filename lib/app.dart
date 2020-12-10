import 'package:econet/auth_widget.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/timeslot.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/ecopoint_repository.dart';
import 'package:econet/views/GMap/filter_testing.dart';
import 'package:econet/views/auth/ecollector_or_regular.dart';
import 'package:econet/views/auth/login_or_signup.dart';
import 'package:econet/views/auth/signup_email.dart';
import 'package:econet/views/auth/signup_method.dart';
// import 'package:econet/views/Gmap/EcopointInfo.dart';
import 'package:econet/views/ecopoint/ecopoint_expanded.dart';
import 'package:econet/views/ecopoint/pickDelivery.dart';
import 'package:flutter/cupertino.dart';
// import 'package:econet/views/GMap/Ecopoint.dart';
import 'package:flutter/material.dart';
import 'package:econet/views/GMap/GMap.dart';
import 'package:econet/views/auth/tutorial.dart';
import 'package:econet/views/auth/login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import 'package:econet/services/user.dart';

import 'package:econet/views/ecopoint/pickDelivery.dart';
import 'package:econet/views/ecopoint/pickTime.dart';

import 'model/my_user.dart';
import 'model/residue.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
              create: (_) => FirebaseAuthProvider()),
          ChangeNotifierProvider<EcopointProvider>(
              create: (_) => FirebaseEcopointProvider()),
        ],
        child: MaterialApp(
          initialRoute: '/auth',
          routes: {
            '/': (context) => MyHomePage(title: 'Econet is flying high'),
            '/loginsignup': (context) => LoginOrSignup(),
            '/signup_method': (context) => SignUpMethod(),
            '/GMap': (context) => GMap(),
            '/tutorial': (context) => Tutorial(),
            '/signup_email': (context) => SignupEmail(),
            '/login': (context) => Login(),
            '/ecollector_or_regular': (context) => EcollectorOrRegular(),
            '/filter_testing': (context) => FilterTesting(),
            '/auth': (context) => AuthWidget(),
            '/ecopoint_expanded': (context) => EcopointExpanded(),
            '/pickDelivery': (context) => PickDelivery(),
            '/pickTime': (context) => PickTime(),
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: MaterialColor(0xFFA3CB8F, _color),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            canvasColor: MaterialColor(0xFFA3CB8F, _color),
            // el navigation drawer toma este color de fondo
            splashColor: Colors.white.withOpacity(0.4),
            highlightColor: Colors.white.withOpacity(0.1),
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0)),
            fontFamily: 'SFProDisplay',
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = "p2"}) : super(key: key);
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
    final ecopointRepository =
        Provider.of<EcopointProvider>(context, listen: false);
    final userRepository = Provider.of<AuthProvider>(context, listen: false);
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
              child: Text("GET ECOPOINT"),
              onPressed: () async {
                print("HOLAAAAAAAAAAAAAAAA 1");

                final Ecopoint aux = await ecopointRepository
                    .getEcopoint("eTFWTvfjSnszbcs9k1Cb");
                print(aux.toString());
              },
            ),
            RaisedButton(
              child: Text("GET ECOPOINT BY MATERIALS"),
              onPressed: () async {
                print("HOLAAAAAAAAAAAAAAAA 1");

                final List<Ecopoint> aux = (await ecopointRepository
                    .getEcopointsByMaterials(['Paper']));
                print(aux.toString());
              },
            ),
            RaisedButton(
              child: Text("Get Current User"),
              onPressed: () async {
                final user = await userRepository.getCurrentUser();
                print("USEEEEER ===" + user.toString());
              },
            ),
            RaisedButton(
              child: Text("Create ecopoint"),
              onPressed: () {
                // MyUser user = MyUser.complete("agustintormakh",
                //     "agustormakh@gmail.com", "11740590", "hola", true);
                final ecopoint = Ecopoint(
                    null,
                    false,
                    [Residue.paper, Residue.glass],
                    "",
                    new DateTime.now(),
                    [new TimeSlot(5), new TimeSlot(3)],
                    "",
                    "testing create",
                    "chacras del mar",
                    LatLng(20.04, 30.04));

                ecopointRepository
                    .createEcopoint(ecopoint)
                    .catchError((error) => print(error.toString()))
                    .then((value) => print(value.toString()));
              },
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
              child: Text("filters"),
              onPressed: () {
                Navigator.pushNamed(context, '/filter_testing');
              },
            ),
            RaisedButton(
                child: Text("delivery"),
                onPressed: () {
                  Navigator.pushNamed(context, '/pickDelivery');
                }),
            ecopointAvailable
                ? SafeArea(
                    child: ListView.builder(
                      itemCount: ecopoints.length,
                      itemBuilder: (context, index) {
                        Ecopoint aux = ecopoints[index];
                        return ListTile(
                          title: Text(
                              '${aux.getLatitude()},${aux.getLongitude()}'),
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

// Para convertir el color de la app en un Material Color y poder definirlo como default
Map<int, Color> _color = {
  50: Color(0xFFC0DEA9), //GREEN_LIGHT
  100: Color(0xFFA3CB8F), //GREEN_MEDIUM
  200: Color(0xFF73A858),
  300: Color(0xFF649A3B), //GREEN_DARK
  400: Color(0xFF467523),
  500: Color(0xFF2F5711),
  600: Color(0xFF25480A),
  700: Color(0xFF23430B),
  800: Color(0xFF1B3607),
  900: Color(0xFF173005),
};
