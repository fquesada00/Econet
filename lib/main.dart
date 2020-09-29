import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:econet/Ecopoint.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.green,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Econet is flying high'),
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

  void _incrementCounter() async{
    ecopoints = await getEcopoints(343, 343, 432);
    if(ecopoints != null && ecopoints.length != 0){
      setState(() {
        ecopointAvailable=true;
        _counter++;
      });
    }else{
      setState(() {
        ecopointAvailable=false;
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
              onPressed: (){ Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapSample()),
              );},
            ),
            ecopointAvailable?SafeArea(

              child: ListView.builder(

                  itemCount: ecopoints.length,
                  itemBuilder: (context, index) {
                    Ecopoint aux = ecopoints[index];
                    return ListTile(
                      title: Text('${aux.latitude},${aux.longitude}'),
                    );
                  },),
            )
                :
            Container(),
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

Future<List<Ecopoint>> getEcopoints(double latitude,double longitude, double radius) async {
  final response = await http.get(
    'https://us-central1-econet-8552d.cloudfunctions.net/ecopoint?radius=10&latitude=-58.479677&longitude=-34.523644',
    //headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  print("RESPONSE BODY =========================================================== "+  response.body);
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
    target: LatLng(-34.523644,-58.479677),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Future<void> initState()  {
  ecopoints =  getEcopoints(4536456, 2345234, 5435);

//    ecopoints.forEach((element) {markers.add(createMarker(element.latitude, element.longitude));});
    markers.add(createMarker("markerDefault",-34.523274,-58.479917));
    _setMarkerIcon();
    super.initState();
  }

  _setMarkerIcon() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(),"assets/icons/recycle2.png");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:
      Container(
        child: FutureBuilder<List<Ecopoint>>(
          future: ecopoints,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              snapshot.data.forEach((element) {
                print(element);
                markers.add(createMarker(element.userEmail,element.longitude, element.latitude));});
            }
            return GoogleMap(
              markers: markers.toSet(),
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
        )
      ),
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: _goToTheLake,
//        label: Text('To the lake!'),
//        icon: Icon(Icons.directions_boat),
//      ),
    );
  }

  Marker createMarker(String id,double latitude,double longitude) {
    LatLng latlng = LatLng(latitude, longitude);
    return  Marker(
      markerId: MarkerId(id),
      position: latlng,
      icon: BitmapDescriptor.defaultMarker,//markerIcon!=null? markerIcon:BitmapDescriptor.defaultMarker,
      draggable: false,
      zIndex: 1,
    );

  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
