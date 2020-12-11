import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/services/cache.dart';
import 'package:econet/services/ecopoint_repository.dart';
import 'package:econet/views/GMap/EcopointInfo.dart';
import 'package:econet/views/widgets/GMapNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GMap extends StatefulWidget {
  @override
  State<GMap> createState() => GMapState();
}

class GMapState extends State<GMap> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController text_controller = new TextEditingController();
  Set<Marker> markers = Set();
  BitmapDescriptor markerEcopointIcon;
  BitmapDescriptor markerPlantIcon;
  static bool searchingFlag = false, loadingPosition = false;
  static LatLng _initialPosition;
  static double ECOPOINT_RADIUS;
  static List<String> filteredElements;

  @override
  void initState() {
    super.initState();
    //asigno variable de icono a marcadores de ecopoints
    _setMarkerIcon();
    filteredElements = List();
    Cache.read("ECOPOINT_RADIUS").then((value) {
      print("ECOPOINT_RADIUS LEVANTADO");
      ECOPOINT_RADIUS = value['value'];
      getLocation();
    }).catchError((error) {
      print("ECOPOINT_RADIUS BASE");
      ECOPOINT_RADIUS = 16.0;
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _initialPosition == null
        ? Container(
            //la posicion actual tarda en cargar, sin este if se muestra un error
            color: Colors.white,
            alignment: Alignment.center,
            child: (!loadingPosition)
                ? Text("Please enable system location.")
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(GREEN_MEDIUM),
                  ))
        : Stack(
            children: <Widget>[
              GoogleMap(
                //Con esto sacamos el logo de Google: Cuidado que si
                //queremos subir esto al Play Store nos hacen quilombo
                markers: markers,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
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
                GMapNavBar(
                  withBack: true,
                  searchingFlag: searchingFlag,
                  switchSearchState: switchSearchState,
                  backgroundColor: Colors.transparent,
                  textColor: GREEN_MEDIUM,
                  text_controller: text_controller,
                  onFilledAdress: () {
                    findNewAddress();
                  },
                  filterElements: filteredElements,
                  updateFilterResidues: (String residueName, bool add) {
                    if (add)
                      filteredElements.add(residueName);
                    else
                      filteredElements.remove(residueName);
                  },
                ),
              Positioned(
                bottom: 20,
                right: 10,
                child: MaterialButton(
                  height: 55,
                  elevation: 15,
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () async {
                    getLocation();
                    final GoogleMapController controller = await _controller.future;
                    controller.animateCamera(CameraUpdate.newLatLng(_initialPosition));
                  },
                  child: Icon(
                    FontAwesomeIcons.crosshairs,
                    size: 45,
                  ),
                  padding: EdgeInsets.all(10),
                  shape: CircleBorder(),
                ),
              ),
              if (loadingPosition)
                Center(
                  child: Container(
                    //la posicion actual tarda en cargar, sin este if se muestra un error
                    color: Color.fromARGB(100, 0, 0, 0),
                    alignment: Alignment.center,
                    child: (!loadingPosition)
                        ? Text("Please enable system location.")
                        : CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                  ),
                ),
            ],
          );
  }

  void findNewAddress() async {
    loadingPosition = true;
    setState(() {});
    var addresses;
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
    } else {
      print("No hubieron resultados en la busqueda");
      loadingPosition = false;
      setState(() {});
    }
  }

  Future<void> changeLocation(double newLatitude, double newLongitude) async {
    if (!loadingPosition) {
      loadingPosition = true;
      setState(() {});
    }

    markers.add(createMarker("positionMarker", newLatitude, newLongitude,
        newLatitude.toString() + newLongitude.toString(), context, null));
    final ecopointRepository =
        Provider.of<EcopointProvider>(context, listen: false);

    await ecopointRepository
        .getEcopointsByRadius(ECOPOINT_RADIUS, newLatitude, newLongitude)
        .then((ecopointList) {
      ecopointList.forEach((ecopoint) {
        bool isFinished = ecopoint.deadline.isBefore(DateTime.now());
        //Si hay filtros, me fijo que el ecopoint los cumpla, si no hay filtros lo meto
        bool isFiltered = true;
        for (int i = 0; i < filteredElements.length; i++) {
          if (filteredElements[i] == 'Ecopoints Only') {
            if (ecopoint.isPlant) {
              isFiltered = false;
              break;
            }
          } else if (filteredElements[i] == 'Recycling Plants Only') {
            if (!ecopoint.isPlant) {
              isFiltered = false;
              break;
            }
          } else if (!ecopoint.residues
              .contains(residueFromString(filteredElements[i]))) {
            isFiltered = false;
            break;
          }
        }

        print("MARKER NAME: " +
            ((ecopoint.name != null) ? ecopoint.name : "null") +
            " IS PLANT? " +
            ((ecopoint.isPlant) ? "YES" : "NO") +
            ", IS FINISHED? " +
            ((isFinished) ? "YES" : "NO") +
            ", CONTAINED BY FILTER: " +
            ((isFiltered) ? "YES" : "NO"));

        if (!isFinished && isFiltered) {
          print("AGREGADO MARKER");
          markers.add(createMarker(
              (ecopoint.isPlant) ? "plantMarker" : "ecopointMarker",
              ecopoint.getLatitude(),
              ecopoint.getLongitude(),
              ecopoint.address,
              context,
              ecopoint));
        }
      });
    });

    loadingPosition = false;
    //notifico al sistema de que hubieron cambios
    setState(() {});
  }

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
    _initialPosition =
        new LatLng(currentPosition.latitude, currentPosition.longitude);

    await changeLocation(currentPosition.latitude, currentPosition.longitude);

    return;
  }

  void switchSearchState() {
    searchingFlag = !searchingFlag;
    //limpio markers y los vuelvo a cargar con los cambios de los filtros
    markers.clear();
    changeLocation(_initialPosition.latitude, _initialPosition.longitude);
  }

  _setMarkerIcon() async {
    markerEcopointIcon =
        await _iconToMarker(CustomIcons.recycle, 80, GREEN_DARK);
    markerPlantIcon = await _bitmapDescriptorFromSvgAsset(
        context, 'assets/icons/factory_icon.svg');
  }

  Marker createMarker(String type, double latitude, double longitude,
      String adress, context, Ecopoint ecopoint) {
    LatLng latlng = LatLng(latitude, longitude);
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
    if (type == "ecopointMarker")
      icon = markerEcopointIcon; // icono de ecopoint
    else if (type == "plantMarker") icon = markerPlantIcon;

    String id = (ecopoint != null) ? ecopoint.toJson().toString() : type;
    return Marker(
      markerId: MarkerId(id),
      position: latlng,
      icon: icon,
      draggable: false,
      zIndex: 1,
      //Calling the function that does the popup
      onTap: () {
        if (type == "ecopointMarker" || type == "plantMarker")
          showModalBottomSheet(
            context: context,
            builder: (builder) {
              return EcopointInfo(
                  ecopoint: ecopoint,
                  distance: Geolocator.distanceBetween(
                          latitude,
                          longitude,
                          _initialPosition.latitude,
                          _initialPosition.longitude) /
                      1000);
            },
          );
      },
    );
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

Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
    BuildContext context, String assetName) async {
  // Read SVG file as String
  String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
  // Create DrawableRoot from SVG String
  DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, null);

  // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
  MediaQueryData queryData = MediaQuery.of(context);
  double devicePixelRatio = queryData.devicePixelRatio;
  double width = 32 * devicePixelRatio; // where 32 is your SVG's original width
  double height = 32 * devicePixelRatio; // same thing

  // Convert to ui.Picture
  ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

  // Convert to ui.Image. toImage() takes width and height as parameters
  // you need to find the best size to suit your needs and take into account the
  // screen DPI
  ui.Image image = await picture.toImage(width.truncate(), height.truncate());
  ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
}
//From guide here https://stackoverflow.com/questions/55655554/using-svg-markers-in-google-maps-flutter-flutter-plugin
