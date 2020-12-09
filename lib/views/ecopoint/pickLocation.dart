import 'dart:async';

import 'package:econet/model/ecopoint.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/GMap/EcopointInfo.dart';
import 'package:econet/views/GMap/GMap.dart';
import 'package:econet/views/widgets/GMapNavBar.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/positive_negative_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocation extends StatefulWidget {
  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  static bool loadingPosition = false;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;
  TextEditingController text_controller = new TextEditingController();
  List<Marker> markers = List();
  static LatLng _initialPosition;
  Ecopoint ecopoint;

  @override
  Future<void> initState() {
    Future.delayed(Duration.zero, () {
      setState(() async {
        ecopoint = ModalRoute.of(context).settings.arguments;
        if (ecopoint != null) {
          // me muevo al nuevo punto
          controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newLatLng(new LatLng(
              ecopoint.coordinates.latitude, ecopoint.coordinates.longitude)));
          changeLocation(
              ecopoint.coordinates.latitude, ecopoint.coordinates.longitude);
        } else {
          getLocation();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Border radius de la search bar
    final BorderRadius _BORDER_RADIUS = BorderRadius.circular(60);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: (_initialPosition == null)
          ? Container(
              //la posicion actual tarda en cargar, sin este if se muestra un error
              alignment: Alignment.center,
              child: (!loadingPosition)
                  ? Text("Please enable system location.")
                  : CircularProgressIndicator())
          : Column(
              children: <Widget>[
                NavBar(
                  text: 'Pick a location for your Ecopoint',
                  withBack: true,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        //Con esto sacamos el logo de Google: Cuidado que si
                        //queremos subir esto al Play Store nos hacen quilombo

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
                      Positioned(
                        top: 0,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Material(
                            color: Colors.transparent,
                            elevation: 5,
                            borderRadius: _BORDER_RADIUS,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: _BORDER_RADIUS,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.search,
                                      size: 25,
                                    ),
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: text_controller,
                                      onSubmitted: (String s) {
                                        // si se ingreso una direccion
                                        if (text_controller.value.text.length >
                                            0) findNewAddress();
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: _BORDER_RADIUS,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: _BORDER_RADIUS,
                                        ),
                                        hintText: "Search locations, filters",
                                        hintStyle: TextStyle(
                                          fontFamily: 'SFProDisplay',
                                          fontSize: 17,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child:
                            PositiveNegativeButtons("Confirm", "Discard", () {
                              if(ecopoint != null){
                                //TODO: POSTEAR A API EL CAMBIO DE DIRECCION

                              }else{
                                //TODO: ESTA CREANDO UN ECOPOINT, SEGUIR EL CAMINO

                              }
                        }, () {
                          print("hmhmn't");
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // Hay mucho codigo repetido respecto de GMap pero se debe a que hacerlos static
  // era mucho quilombo por la cantidad de variables de contexto que usan y ademas
  // ciertas diferencias como que aca no hay ecopoints ni dialog
  void getLocation() async {
    await Geolocator.requestPermission();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("NO HAY PERMISOS DE UBICACION, PERMISOS " + permission.toString());
      return;
    }

    setState(() {
      loadingPosition = true;
      print("LOADING POSITION");
    });

    Position currentPosition;
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
    markers.add(GMapState.createMarker(
        "positionMarker",
        newLatitude,
        newLongitude,
        newLatitude.toString() + newLongitude.toString(),
        context,
        null));

    //notifico al sistema de que hubieron cambios
    setState(() {});
  }
}
