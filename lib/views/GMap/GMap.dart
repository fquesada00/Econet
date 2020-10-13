import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:econet/presentation/custom_icons_icons.dart';
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
    markerIcon = await _iconToMarker(CustomIcons.recycle, 80, GREEN_DARK);
    // await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 1),
    //     'assets/icons/recycle_icon.png'); // por alguna razon no puedo modificar el tamanio, tuve que cambiar el de la imagen manualmente
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GMapNavBar(
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
              )),
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

Future<BitmapDescriptor> _iconToMarker(IconData icon, double size, Color color) async {
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
      )
  );
  textPainter.layout();
  textPainter.paint(canvas, Offset(0.0, 0.0));

  final picture = pictureRecorder.endRecording();
  final image = await picture.toImage(size.floor(), size.floor());
  final bytes = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
}