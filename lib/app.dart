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
import 'package:econet/views/ecopoint/PickTimeCreateEcopoint.dart';
import 'package:econet/views/ecopoint/add_bags.dart';
import 'package:econet/views/ecopoint/ecopoint_details.dart';
import 'package:econet/views/ecopoint/ecopoint_expanded.dart';
import 'package:econet/views/ecopoint/ecopoint_overview.dart';
import 'package:econet/views/ecopoint/pickDeliveryDate.dart';
import 'package:econet/views/ecopoint/pickLocation.dart';
import 'package:econet/views/ecopoint/pickMaterials.dart';
import 'package:econet/views/ecopoint/pickWeekdayCreateEcopoint.dart';
import 'package:econet/views/my_ecopoint/my_ecopoint.dart';
import 'package:econet/views/my_ecopoint/pending_details.dart';
import 'package:econet/views/my_ecopoint/request_details.dart';
import 'package:econet/views/my_recycling/my_delivery_details.dart';
import 'package:econet/views/my_recycling/my_recycling.dart';
import 'package:econet/views/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/views/GMap/Ecopoint.dart' as EcopointView;
import 'package:flutter/material.dart';
import 'package:econet/views/GMap/GMap.dart';
import 'package:econet/views/auth/tutorial.dart';
import 'package:econet/views/auth/login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:econet/model/ecopoint.dart' as EcopointModel;
import 'package:provider/provider.dart';
import 'package:econet/services/user.dart';

import 'package:econet/views/ecopoint/pickTime.dart';
import 'package:econet/views/ecopoint/createEcopoint.dart';

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
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(title: 'Econet is flying high'),
          '/signup_method': (context) => SignUpMethod(),
          '/loginsignup': (context) => LoginOrSignup(),
          '/GMap': (context) => GMap(),
          '/tutorial': (context) => Tutorial(),
          '/signup_email': (context) => SignupEmail(),
          '/login': (context) => Login(),
          '/ecollector_or_regular': (context) => EcollectorOrRegular(),
          '/filter_testing': (context) => FilterTesting(),
          '/ecopoint_expanded': (context) => EcopointExpanded(),
          '/pickDeliveryMaterials': (context) => PickMaterials(),
          '/pickTime': (context) => PickTime(),
          '/createEcopoint': (context) => CreateEcopoint(),
          '/pickWeekday': (context) => PickWeekday(),
          '/ecopointExpanded': (context) => EcopointExpanded(),
          '/pickTimeCreateEcopoint': (context) => PickTimeCreateEcopoint(),
          '/pickDeliveryDate': (context) => PickDeliveryDate(),
          '/settings': (context) => Settings(),
          '/pickLocation': (context) => PickLocation(),
          '/my_recycling': (context) => MyRecycling(),
          '/add_bags': (context) => AddBags(),
          '/my_ecopoint': (context) => MyEcopoint(),
          '/ecopoint_details': (context) => EcopointDetails(),
          '/ecopoint_overview': (context) => EcopointOveriew(),
          '/pending_delivery_details': (context) => PendingDetails(),
          '/my_delivery_details': (context) => MyDeliveryDetails(),
          '/request_delivery_details': (context) => RequestDetails(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: MaterialColor(0xFFA3CB8F, _color),
          canvasColor: MaterialColor(0xFFA3CB8F, _color),
          // el navigation drawer toma este color de fondo
          splashColor: Colors.white.withOpacity(0.4),
          highlightColor: Colors.white.withOpacity(0.1),
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0)),
          fontFamily: 'SFProDisplay',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = "p2"}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        child: SingleChildScrollView(
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
                  child: Text("pickMaterials"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/pickDeliveryMaterials');
                  }),
              RaisedButton(
                  child: Text("pickLocation"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/pickLocation');
                  }),
              RaisedButton(
                  child: Text("sheduleTrip"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/createEcopoint', arguments: {
                      'plantName': "Plant 1",
                      'address': "Adress 1234",
                      'distance': 0.2,
                      'residues': [
                        'Paper',
                        'Plastic',
                        'Glass',
                        'Metal',
                        'Electronics',
                        'Wood',
                        'Textile'
                      ],
                    });
                  }),
              RaisedButton(
                  child: Text("ecopointExpanded"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/ecopointExpanded',
                        arguments: {
                          'ecopointName': "Plant 1",
                          'address': "Adress 1234",
                          'distance': 0.2,
                          'residues': [
                            'Paper',
                            'Plastic',
                            'Glass',
                            'Metal',
                            'Electronics',
                            'Wood',
                            'Textile'
                          ],
                          'ecollector': "ecollector",
                          'deliveryDate': new DateTime.utc(2020, 10, 26),
                        });
                  }),
              RaisedButton(
                  child: Text("pickWeekday"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/pickWeekday');
                  }),
              // RaisedButton(
              //   child: Text("pickTimeCreateEcopoint"),
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/pickTimeCreateEcopoint',
              //         arguments: {
              //           "daysAvailable": [
              //             false,
              //             true,
              //             false,
              //             true,
              //             false,
              //             true,
              //             true
              //           ],
              //           "currentDay": "TUESDAY",
              //         });
              //   },
              // ),
              RaisedButton(
                  child: Text("settings"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  }),
              RaisedButton(
                  child: Text("my recycling"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/my_recycling');
                  }),
              RaisedButton(
                child: Text("Add Bags"),
                onPressed: () {
                  Navigator.pushNamed(context, '/add_bags');
                },
              ),
              RaisedButton(
                child: Text("My ecopoint"),
                onPressed: () {
                  Navigator.pushNamed(context, '/my_ecopoint');
                },
              ),
              RaisedButton(
                child: Text("ecopoint overview"),
                onPressed: () {
                  Navigator.pushNamed(context, '/ecopoint_overview');
                },
              ),
              RaisedButton(
                child: Text("ecopoint details"),
                onPressed: () {
                  Navigator.pushNamed(context, '/ecopoint_details');
                },
              ),
            ],
          ),
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
