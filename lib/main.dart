import 'dart:async';
import 'dart:convert';
import 'package:econet/views/auth/login_or_signup.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:econet/Ecopoint.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class EconetButton extends StatelessWidget {
  EconetButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 33,
              width: 33,
              child: Image.asset(
                'assets/icons/econet-circle-logo-white.png',
              ),
            ),
            Text("RECYCLE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'SFProDisplay'),
                softWrap: false),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFFA3CB8F),
        onPressed: onPressed,
    );
  }
}

// Para convertir el color de la app en un Material Color y poder definirlo como default
Map<int, Color> color = {
  50: Color.fromRGBO(163, 203, 143, .1),
  100: Color.fromRGBO(163, 203, 143, .2),
  200: Color.fromRGBO(163, 203, 143, .3),
  300: Color.fromRGBO(163, 203, 143, .4),
  400: Color.fromRGBO(163, 203, 143, .5),
  500: Color.fromRGBO(163, 203, 143, .6),
  600: Color.fromRGBO(163, 203, 143, .7),
  700: Color.fromRGBO(163, 203, 143, .8),
  800: Color.fromRGBO(163, 203, 143, .9),
  900: Color.fromRGBO(163, 203, 143, 1),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Econet is flying high'),
        '/loginsignup': (context) => LoginOrSignup(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFA3CB8F, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: MaterialColor(0xFFA3CB8F, color), // el navigation drawer toma este color de fondo
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
    ecopoints = await getEcopoints(343, 343, 432);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have saved this many bags from the trash:',
            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
            RaisedButton(
              child: Text("maps"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapSample()),
                );
              },
            ),
            RaisedButton(
              child: Text('Login screen'),
              onPressed: () {
                Navigator.pushNamed(context, '/loginsignup');
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
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<List<Ecopoint>> getEcopoints(double latitude, double longitude,
    double radius) async {
  final response = await http.get(
    'https://us-central1-econet-8552d.cloudfunctions.net/ecopoint?radius=10&latitude=-58.479677&longitude=-34.523644',
    //headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  print(
      "RESPONSE BODY =========================================================== " +
          response.body);
  final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

  return parsed.map<Ecopoint>((json) => Ecopoint.fromJson(json)).toList();
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = List();
  Future<List<Ecopoint>> ecopoints;
  BitmapDescriptor markerIcon;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-34.523644, -58.479677),
    zoom: 15.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Future<void> initState() {
    ecopoints = getEcopoints(4536456, 2345234, 5435);

//    ecopoints.forEach((element) {markers.add(createMarker(element.latitude, element.longitude));});
    markers.add(
        createMarker("markerDefault", -34.523274, -58.479917, "TesterCalle"));
    _setMarkerIcon();
    super.initState();
  }

  _setMarkerIcon() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1),
        'assets/icons/recycle_icon.png'); // por alguna razon no puedo modificar el tamanio, tuve que cambiar el de la imagen manualmente
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("no se como poner la appbar default"),
        ),
        drawer: AppDrawer(),
        body: Stack(children: <Widget>[
          Container(
              child: FutureBuilder<List<Ecopoint>>(
                future: ecopoints,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    snapshot.data.forEach((element) {
                      print(element);
                      markers.add(
                          createMarker(element.userEmail, element.longitude,
                              element.latitude, element.adress));
                    });
                  }

                  return GoogleMap(
                    markers: markers.toSet(),
                    zoomControlsEnabled: false,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  );

                  //            if (snapshot.hasData) {
                  //              return Text(snapshot.data.title);
                  //            } else if (snapshot.hasError) {
                  //              return Text("${snapshot.error}");
                  //            }
                  //
                  //            // By default, show a loading spinner.
                  //            return CircularProgressIndicator();
                },
              )),
          Container(
            margin: EdgeInsets.fromLTRB(200, 0, 15, 10),
            child: EconetButton(onPressed: () {
              print("HOLA");
            }),
            alignment: Alignment.bottomRight,
          ),
        ])

//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: _goToTheLake,
//        label: Text('To the lake!'),
//        icon: Icon(Icons.directions_boat),
//      ),
    );
  }

  Marker createMarker(String id, double latitude, double longitude,
      String Adress) {
    LatLng latlng = LatLng(latitude, longitude);
    return Marker(
        markerId: MarkerId(id),
        position: latlng,
        icon: markerIcon,
        //markerIcon!=null? markerIcon:BitmapDescriptor.defaultMarker,
        draggable: false,
        zIndex: 1,
        //Calling the function that does the popup
        onTap: _showPopupMenu);
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  _showPopupMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(50.0, 200.0, 60.0, 0),
      //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(child: const Text("Calle test 000"), value: '1'),
        PopupMenuItem<String>(
            child: const Text('Para poner reciclaje'), value: '2'),
        PopupMenuItem<String>(child: const Text('menu option 3'), value: '3'),
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        //code here
      } else if (itemSelected == "2") {
        //code here
      } else {
        //code here
      }
    });
  }
}
