import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/views/GMap/EcopointInfo.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
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
  BitmapDescriptor markerIcon;
  static bool searchingFlag = false, loadingPosition = false;
  static LatLng _initialPosition;
  static final double ECOPOINT_RADIUS = 15.0;

  @override
  Future<void> initState() {
    //asigno variable de icono a marcadores de ecopoints
    _setMarkerIcon();
    getLocation();
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
        onFilledAdress: () {
          findNewAddress();
        },
      ),
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          if (_initialPosition == null)
            Container(
                //la posicion actual tarda en cargar, sin este if se muestra un error
                alignment: Alignment.center,
                child: (!loadingPosition)
                    ? Text("Please enable system location.")
                    : CircularProgressIndicator())
          else
            GoogleMap(
              //Con esto sacamos el logo de Google: Cuidado que si
              //queremos subir esto al Play Store nos hacen quilombo
              padding: EdgeInsets.symmetric(horizontal: 500),

              markers: markers.toSet(),
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                // target: LatLng(-34.523644, -58.479677), HARDCODEADO
                target: _initialPosition,
                zoom: 15.4746,
              ),
              mapToolbarEnabled: false,
              compassEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
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

  Future<List<Ecopoint>> getEcopoints(
      double latitude, double longitude, double radius) async {
    String request =
        'https://us-central1-econet-8552d.cloudfunctions.net/ecopoint?' +
            'radius=' +
            radius.toString() +
            '&latitude=' +
            latitude.toString() +
            '&longitude=' +
            longitude.toString();
    print("REQUEST:     " + request);
    final response = await http.get(request);
    print(
        "RESPONSE BODY =========================================================== " +
            response.body);
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Ecopoint>((json) => Ecopoint.fromJson(json)).toList();
  }

  void findNewAddress() async {
    var addresses;
    print("TEXTO A BUSCAR: " + text_controller.value.text);
    try {
      addresses = await Geocoder.local
          .findAddressesFromQuery(text_controller.value.text);
    } catch (error) {
      print(error);
      return;
    }

    if (addresses != null && !addresses.isEmpty) {
      var newAddress = addresses.first;
      print("NEW ADDRESS FROM NAVBAR: " +
          "${newAddress.featureName} : ${newAddress.addressLine}");

      final GoogleMapController controller = await _controller.future;
      // me muevo al nuevo punto
      controller.animateCamera(CameraUpdate.newLatLng(new LatLng(
          newAddress.coordinates.latitude, newAddress.coordinates.longitude)));
      // actualizo el marker de posicion actual y ecopoints
      markers.clear();
      await changeLocation(
          newAddress.coordinates.latitude, newAddress.coordinates.longitude);
    }
  }

  Future<void> changeLocation(double newLatitude, double newLongitude) async {
    markers.add(createMarker("positionMarker", newLatitude, newLongitude,
        newLatitude.toString() + newLongitude.toString(), context));

    await getEcopoints(newLatitude, newLongitude, ECOPOINT_RADIUS)
        .then((value) {
      value.forEach((element) {
        print("MARKER ADDED: " + element.toString());
        markers.add(createMarker(element.toString(), element.latitude,
            element.longitude, element.adress, context));
      });
    });

    //notifico al sistema de que hubieron cambios
    setState(() {});
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      return;
    }

    Position currentPosition;
    loadingPosition = true;
    setState(() {});
    
    try {
      //el metodo dentro pide los permisos
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (error) {
      print("ERROR: " + error.toString());
      return;
    }
    // posicion inicial del mapa
    _initialPosition =
        new LatLng(currentPosition.latitude, currentPosition.longitude);

    await changeLocation(currentPosition.latitude, currentPosition.longitude);

    return;
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
    BitmapDescriptor icon;
    if (id == "positionMarker")
      icon = BitmapDescriptor.defaultMarker;
    else
      icon = markerIcon; // icono de ecopoint

    //marcador de la posicion en la que se encontraba al abrir la app
    return Marker(
        markerId: MarkerId(id),
        position: latlng,
        icon: icon,
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
