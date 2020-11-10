import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/GMap/EcopointInfo.dart';
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
  static bool searchingFlag = false;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-34.523644, -58.479677),
    zoom: 15.4746,
  );

  void switchSearchState() {
    searchingFlag = !searchingFlag;
    setState(() {});
  }

  @override
  Future<void> initState() {
    ecopoints = getEcopoints(4536456, 2345234, 5435);

//   This is just for testing, replace user position or last cashed position
    markers.add(createMarker(
        "markerDefault", -34.523274, -58.479917, "TesterCalle", null));
    _setMarkerIcon();
    super.initState();
  }

  _setMarkerIcon() async {
    markerIcon = await _iconToMarker(CustomIcons.recycle, 80, GREEN_DARK);
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

                return GoogleMap(
                  //Con esto sacamos el logo de Google: Cuidado que si
                  //queremos subir esto al Play Store nos hacen quilombo
                  padding: EdgeInsets.symmetric(horizontal: 500),

                  markers: markers.toSet(),
                  zoomControlsEnabled: false,
                  initialCameraPosition: _kGooglePlex,
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
          /*GMapNavBar(
              text: 'Search',
              withBack: true,
              backgroundColor: Colors.transparent,
              textColor: GREEN_MEDIUM,
              height: 120),*/
        ],
      ),
    );
  }

  Marker createMarker(
      String id, double latitude, double longitude, String adress, context) {
    LatLng latlng = LatLng(latitude, longitude);
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
