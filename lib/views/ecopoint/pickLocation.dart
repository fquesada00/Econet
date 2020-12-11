import 'dart:async';

import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
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
  static LatLng _position;
  Ecopoint ecopoint;
  String _locationAddress;

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
          controller = await _controller.future;
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
      body: (_position == null)
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
                          target: _position,
                          zoom: 15.4746,
                        ),
                        mapToolbarEnabled: false,
                        compassEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onTap: handleTap,
                      ),
                      //BARRA DE BUSQUEDA
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
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 30,
                                    width: 30,
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
                                        if (text_controller.text.length > 0)
                                          findNewAddress();
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
                        child: _LocationConfirmDiscard(_locationAddress, () {
                          if (ecopoint != null) {
                            //TODO: POSTEAR A API EL CAMBIO DE DIRECCION
                            // la informacion del ecopoint a actualizar esta en ecopoint y la direccion del ecopoint en _initialposition

                          } else {
                            //TODO: ESTA CREANDO UN ECOPOINT, SEGUIR EL CAMINO (agregar a viewmodel y navegar)
                            final createEcopointModel =
                                CreateEcopointModel.instance;
                            createEcopointModel.address = _locationAddress;
                            createEcopointModel.coordinates = _position;

                            Navigator.pushNamed(
                                context, '/create_ecopoint_additional');
                          }
                        }, () {
                          // TODO : ELIMINAR MARKER DEL MAPA
                          print("hmhmn't");
                        }),
                      ),
                      if (loadingPosition)
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(GREEN_MEDIUM),
                          ),
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
    _position =
        new LatLng(currentPosition.latitude, currentPosition.longitude);

    List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(
        new Coordinates(currentPosition.latitude, currentPosition.longitude));

    if (addresses != null && addresses.isNotEmpty) {
      _locationAddress = addresses.first.addressLine;
    }

    await changeLocation(currentPosition.latitude, currentPosition.longitude);

    return;
  }

  Future<void> handleTap(LatLng tappedPoint) async {
    setState(() {
      loadingPosition = true;
    });

    markers.clear();

    List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(
        new Coordinates(tappedPoint.latitude, tappedPoint.longitude));

    if (addresses != null && addresses.isNotEmpty) {
      _locationAddress = addresses.first.addressLine;
    }

    changeLocation(tappedPoint.latitude, tappedPoint.longitude);
  }

  void findNewAddress() async {
    var addresses;
    setState(() {
      loadingPosition = true;
    });
    print("TEXTO A BUSCAR: " + text_controller.value.text);
    try {
      addresses = await Geocoder.local
          .findAddressesFromQuery(text_controller.value.text);
    } catch (error) {
      print(error);
      setState(() {
        loadingPosition = false;
      });
      return;
    }

    if (addresses != null && !addresses.isEmpty) {
      Address newAddress = addresses.first;

      print("NEW ADDRESS FROM NAVBAR: " +
          "${newAddress.featureName} : ${newAddress.addressLine}");

      // me muevo al nuevo punto
      controller.animateCamera(CameraUpdate.newLatLng(new LatLng(
          newAddress.coordinates.latitude, newAddress.coordinates.longitude)));
      // actualizo el marker de posicion actual y ecopoints
      markers.clear();
      await changeLocation(
          newAddress.coordinates.latitude, newAddress.coordinates.longitude);
      _position = new LatLng(
          newAddress.coordinates.latitude, newAddress.coordinates.longitude);

      _locationAddress = newAddress.addressLine;
    }

    setState(() {
      loadingPosition = false;
    });
  }

  Marker createMarker(
      String id, double latitude, double longitude, String adress, context) {
    LatLng latlng = LatLng(latitude, longitude);

    //marcador de la posicion en la que se encontraba al abrir la app
    return Marker(
      markerId: MarkerId(id),
      position: latlng,
      icon: BitmapDescriptor.defaultMarker,
      draggable: false,
      zIndex: 1,
    );
  }

  Future<void> changeLocation(double newLatitude, double newLongitude) async {
    if(!loadingPosition) {
      loadingPosition = true;
      setState(() {});
    }
    markers.add(createMarker("positionMarker", newLatitude, newLongitude,
        newLatitude.toString() + newLongitude.toString(), context));
    _position = LatLng(newLatitude, newLongitude);

    //notifico al sistema de que hubieron cambios
    loadingPosition = false;
    setState(() {});
  }
}

class _LocationConfirmDiscard extends StatefulWidget {
  final String address;
  Function positiveButtonFunction;
  Function negativeButtonFunction;

  _LocationConfirmDiscard(
      this.address, this.positiveButtonFunction, this.negativeButtonFunction);

  @override
  __LocationConfirmDiscardState createState() =>
      __LocationConfirmDiscardState();
}

class __LocationConfirmDiscardState extends State<_LocationConfirmDiscard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          color: GREEN_MEDIUM,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.address,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 100,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Button1(
                btnData: ButtonData(
                  'CONFIRM',
                  widget.positiveButtonFunction,
                  backgroundColor: GREEN_MEDIUM,
                  adjust: true,
                  height: 60,
                  width: 130,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Button1(
                btnData: ButtonData(
                  'DISCARD',
                  widget.negativeButtonFunction,
                  backgroundColor: RED_MEDIUM,
                  adjust: true,
                  height: 60,
                  width: 130,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
