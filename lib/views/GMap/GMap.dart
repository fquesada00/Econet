import 'dart:async';
import 'dart:convert';
import 'package:econet/views/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'Ecopoint.dart';
import 'EconetButton.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:econet/views/widgets/GMapNavBar.dart';
import 'package:econet/presentation/constants.dart';



class GMap extends StatefulWidget {
  @override
  State<GMap> createState() => GMapState();
}

class GMapState extends State<GMap> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = List();
  Future<List<Ecopoint>> ecopoints;
  BitmapDescriptor markerIcon;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-34.523644, -58.479677),
    zoom: 15.4746,
  );
  @override
  Future<void> initState() {
    ecopoints = getEcopoints(4536456, 2345234, 5435);

//   This is just for testing, replace user position or last cashed position
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
        appBar: GMapNavBar(
          height: 120,
          text: 'Search',
          withBack: true,
          backgroundColor: Colors.transparent,
          textColor: GREEN_MEDIUM,
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
                      markers.add(createMarker(element.userEmail, element.longitude,
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
                },
              )),
          Container(
            margin: EdgeInsets.fromLTRB(200, 0, 15, 10),
            child: EconetButton(onPressed: () {
              print("HOLA");
            }),
            alignment: Alignment.bottomRight,
          ),
          /*GMapNavBar(
              text: 'Search',
              withBack: true,
              backgroundColor: Colors.transparent,
              textColor: GREEN_MEDIUM,
              height: 120),*/
        ])
    );
  }

  Marker createMarker(
      String id, double latitude, double longitude, String Adress) {
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
Future<List<Ecopoint>> getEcopoints(
    double latitude, double longitude, double radius) async {
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