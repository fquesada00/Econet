import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/model/timerange.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/presentation/custom_icons_icons.dart';
import 'package:econet/services/delivery_repository.dart';
import 'package:econet/services/ecopoint_repository.dart';
import 'package:econet/services/user.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/text_above_numbered_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRecyclingEcopointsTab extends StatefulWidget {
  @override
  _MyRecyclingEcopointsTabState createState() =>
      _MyRecyclingEcopointsTabState();
}

// Clase auxiliar solo utilizada en este .dart
class EcopointDeliveryExtraInfo {
  Ecopoint ecopoint;
  int pendingDeliveries;
  int requestedDeliveries;

  EcopointDeliveryExtraInfo(
      this.ecopoint, this.pendingDeliveries, this.requestedDeliveries);
}

class _MyRecyclingEcopointsTabState extends State<MyRecyclingEcopointsTab> {
  List<EcopointDeliveryExtraInfo> ecopointList = [];
  bool isEcollector = false, loadingEcopoints = true;
  String currentUserEmail;

  @override
  void initState() {
    super.initState();
    getInformation();
  }

  getInformation() async {
    AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);

    await provider.getCurrentUser().then((user) {
      isEcollector = user.isEcollector;
      currentUserEmail = user.email;
      setState(() {});
      fillDeliveries();
    });
  }

  Future<void> fillDeliveries() async {
    EcopointProvider ecopointRepository =
        Provider.of<EcopointProvider>(context, listen: false);
    DeliveryProvider deliveryRepository =
        Provider.of<DeliveryProvider>(context, listen: false);

    await ecopointRepository
        .getEcopointsByUser(currentUserEmail)
        .then((auxListEcopoints) {
      int listSize = auxListEcopoints.length;
      auxListEcopoints.forEach((ecopoint) async {
        // busco los ecopoints no terminados del user actual,
        // y busco los deliveries de cada uno para contarlos segun corresponda
        if (ecopoint.deadline.isAfter(DateTime.now())) {
          int pendingDeliveries = 0;
          int requestedDeliveries = 0;
          await deliveryRepository
              .getDeliveriesInEcopoint(ecopoint.id)
              .then((deliveries) {
            deliveries.forEach((delivery) {
              if (!delivery.finished) {
                if (!delivery.responseValue) {
                  // si no termino y no le respondi es un request
                  requestedDeliveries++;
                } else if (delivery.isConfirmed) {
                  // si no termino, le respondi y lo confirme es un pending
                  pendingDeliveries++;
                }
              }
            });
          });
          print("LOADED ECOPOINT: " + ecopoint.name);
          ecopointList.add(EcopointDeliveryExtraInfo(
              ecopoint, pendingDeliveries, requestedDeliveries));
          if (ecopointList.length == listSize) {
            loadingEcopoints = false;
            setState(() {});
          }
        }
      });
      if (auxListEcopoints.isEmpty) {
        loadingEcopoints = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: GREEN_MEDIUM,
      ),
      child: (!loadingEcopoints && !isEcollector)
          ? Center(
              child: Button1(
                btnData: ButtonData("BECOME AN ECOLLECTOR", () {},
                    backgroundColor: BROWN_DARK,
                    textColor: Colors.white,
                    icon: Icon(
                      CustomIcons.recycle,
                      color: Colors.white,
                    ),
                    fontSize: 28),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 15),
              child: (loadingEcopoints || ecopointList.isEmpty)
                  ? Container(
                      height: 100,
                      child: Center(
                        child: (!loadingEcopoints)
                            ? Text(
                                "No ecopoints available",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontFamily: 'SFProDisplay',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: List.from(
                        ecopointList.map(
                          (e) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/my_ecopoint',
                                  arguments: e.ecopoint);
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 15, left: 15, right: 15),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 55,
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text(
                                                  (e.ecopoint.name != null)
                                                      ? e.ecopoint.name
                                                      : '',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: GREEN_DARK,
                                                    fontSize: 22,
                                                    fontFamily: 'SFProDisplay',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 34,
                                            ),
                                            Container(
                                              height: 72,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Text(
                                                      "Due in",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        fontFamily:
                                                            'SFProDisplay',
                                                      ),
                                                    ),
                                                  ),
                                                  Chip(
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    label: Text(
                                                      TimeRange
                                                          .getRemainingDeliverTime(
                                                              e.ecopoint
                                                                  .deadline),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontFamily:
                                                            'SFProDisplay',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    backgroundColor: BROWN_DARK,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              width: 60,
                                              child: TextAboveNumberedCircle(
                                                  "Pending deliveries",
                                                  e.pendingDeliveries,
                                                  GREEN_DARK),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              width: 60,
                                              child: TextAboveNumberedCircle(
                                                  "Delivery requests",
                                                  e.requestedDeliveries,
                                                  BROWN_MEDIUM),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 55,
                                    alignment: Alignment.topCenter,
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 36,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
