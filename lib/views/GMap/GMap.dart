import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/GMap/EcopointInfo.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
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
  TextEditingController text_controller = new TextEditingController();
  List<Marker> markers = List();
  Future<List<Ecopoint>> ecopoints;
  BitmapDescriptor markerIcon;
  static bool searchingFlag = false;
  static LatLng _initialPosition; //para que no de error de null al arrancar

  void getLocation() async {
    Position currentPosition;
    try {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (error) {
      print("ERROR: " + error.toString());
      return;
    }
    //HARDCODEADO
    // markers.add(createMarker("positionMarker", -34.523274, -58.479917, "TesterCalle", null));

    //NO HARDCODEADO, toma posicion real del dispositivo
    markers.add(createMarker("positionMarker", currentPosition.latitude,
        currentPosition.longitude, currentPosition.toString(), null));
    setState(() {
      _initialPosition =
          new LatLng(currentPosition.latitude, currentPosition.longitude);
    });
    return;
  }

  @override
  Future<void> initState() {
    getLocation();
    ecopoints = getEcopoints(4536456, 2345234, 5435);

    //asigno iconos a marcadores
    _setMarkerIcon();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GMapNavBar(
        withBack: true,
        searchingFlag: searchingFlag,
        switchSearchState: switchSearchState,
        backgroundColor: Colors.transparent,
        textColor: GREEN_MEDIUM,
        text_controller: text_controller,
      ),
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            child: FutureBuilder<List<Ecopoint>>(
              future: ecopoints,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  snapshot.data.forEach((element) {
                    print(element);
                    markers.add(createMarker(
                        element.userEmail,
                        element.longitude,
                        element.latitude,
                        element.adress,
                        context));
                  });
                }

                if (_initialPosition == null)
                  //la posicion actual tarda en cargar, sin este if se muestra un error 
                  return Container();
                else
                  return GoogleMap(
                    //Con esto sacamos el logo de Google: Cuidado que si
                    //queremos subir esto al Play Store nos hacen quilombo
                    padding: EdgeInsets.symmetric(horizontal: 500),

                    markers: markers.toSet(),
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      // target: LatLng(-34.523644, -58.479677), HARDCODEADO

                      // el chequeo de null es por que el mapa se crea antes de que se encuentra la posicion actual
                      target: _initialPosition,
                      zoom: 15.4746,
                    ),
                    mapToolbarEnabled: false,
                    compassEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  );
              },
            ),
          ),
          if (!searchingFlag) // Mientras el popup esta abierto, no se ve este boton
            Container(
              margin: EdgeInsets.fromLTRB(200, 0, 15, size.height * 0.05),
              child: EconetButton(onPressed: () {
                print("HOLA");
              }),
              alignment: Alignment.bottomRight,
            ),
        ],
      ),
    );
  }

  void switchSearchState() {
    searchingFlag = !searchingFlag;
    setState(() {});
  }

  _setMarkerIcon() async {
    markerIcon = await _iconToMarker(CustomIcons.recycle, 80, GREEN_DARK);
  }

  Marker createMarker(
      String id, double latitude, double longitude, String adress, context) {
    LatLng latlng = LatLng(latitude, longitude);
    if (id == "positionMarker")
      //marcador de la posicion en la que se encontraba al abrir la app
      return Marker(
          markerId: MarkerId(id),
          position: latlng,
          icon: BitmapDescriptor.defaultMarker,
          draggable: false,
          zIndex: 1,
          //Calling the function that does the popup
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return EcopointInfo();
                });
          });
    else
      return Marker(
          markerId: MarkerId(id),
          position: latlng,
          icon: markerIcon,
          //markerIcon!=null? markerIcon:BitmapDescriptor.defaultMarker,
          draggable: false,
          zIndex: 1,
          //Calling the function that does the popup
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return EcopointInfo();
                });
          });
  }
}

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

Future<BitmapDescriptor> _iconToMarker(
    IconData icon, double size, Color color) async {
  final pictureRecorder = PictureRecorder();
  final canvas = Canvas(pictureRecorder);
  final textPainter = TextPainter(textDirection: TextDirection.ltr);
  final iconStr = String.fromCharCode(icon.codePoint);

  textPainter.text = TextSpan(
      text: iconStr,
      style: TextStyle(
        letterSpacing: 0.0,
        fontSize: size,
        fontFamily: icon.fontFamily,
        color: color,
      ));
  textPainter.layout();
  textPainter.paint(canvas, Offset(0.0, 0.0));

  final picture = pictureRecorder.endRecording();
  final image = await picture.toImage(size.floor(), size.floor());
  final bytes = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
}

//From guide here https://www.abhishekduhoon.com/2020/06/how-to-create-widget-based-google-maps.html
