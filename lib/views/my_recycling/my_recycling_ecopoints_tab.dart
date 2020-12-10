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

class EcopointDeliveryExtraInfo {
  Ecopoint ecopoint;
  int pendingDeliveries;
  int requestedDeliveries;

  EcopointDeliveryExtraInfo(
      this.ecopoint, this.pendingDeliveries, this.requestedDeliveries);
}

class _MyRecyclingEcopointsTabState extends State<MyRecyclingEcopointsTab> {
  List<EcopointDeliveryExtraInfo> deliveriesList = [];
  bool isEcollector = false, loadingEcopoints = true;
  DeliveryProvider deliveryRepository;
  EcopointProvider ecopointRepository;
  String currentUserEmail;

  getUserInfo() async {
    print("GETTING USER");
    AuthProvider provider =
        await Provider.of<AuthProvider>(context, listen: false);
    await provider.getCurrentUser().then((value) {
      if (value.isEcollector) isEcollector = true;
      currentUserEmail = value.email;
      setState(() {});
    });

    print("USER RECEIVED");

    fillDeliveries();
  }

  Future<void> fillDeliveries() async {
    ecopointRepository = Provider.of<EcopointProvider>(context, listen: false);
    deliveryRepository = Provider.of<DeliveryProvider>(context, listen: false);
    print("MBEH");

    await ecopointRepository.getEcopointsByUser(currentUserEmail).then((value) {
      value.forEach((ecopoint) async {
        // busco los ecopoints no terminados del user actual,
        // y busco los deliveries de cada uno para contarlos segun corresponda
        if (ecopoint.deadline.isAfter(DateTime.now())) {
          int pendingDeliveries = 0;
          int requestedDeliveries = 0;
          await deliveryRepository
              .getDeliveriesInEcopoint(ecopoint.id)
              .then((value) {
            value.forEach((element) {
              print("ELEMENTO = " + element.toString());
              if (!element.finished) {
                if (!element.responseValue) {
                  // si no termino y no le respondi es un request
                  requestedDeliveries++;
                } else if (element.isConfirmed) {
                  // si no termino, le respondi y lo confirme es un pending
                  pendingDeliveries++;
                }
              }
            });
          });
          deliveriesList.add(EcopointDeliveryExtraInfo(
              ecopoint, pendingDeliveries, requestedDeliveries));

          loadingEcopoints = false;
          setState(() {});
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
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
      //TODO: SACAR EL (false) ES PARA TESTEOS
      child: (false) /*(!isEcollector)*/
          ? Expanded(
              child: Center(
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
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 15),
              child: (loadingEcopoints)
                  ? Container(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: List.generate(deliveriesList.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/my_ecopoint',
                                arguments: deliveriesList[index]);
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
                                          Expanded(
                                            flex: 4,
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                (deliveriesList[index]
                                                            .ecopoint
                                                            .name !=
                                                        null)
                                                    ? deliveriesList[index]
                                                        .ecopoint
                                                        .name
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
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Spacer(),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
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
                                                              deliveriesList[
                                                                      index]
                                                                  .ecopoint
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
                                          ),
                                          Spacer(),
                                          Expanded(
                                            flex: 2,
                                            child: TextAboveNumberedCircle(
                                                "Pending deliveries",
                                                deliveriesList[index]
                                                    .pendingDeliveries,
                                                GREEN_DARK),
                                          ),
                                          Spacer(),
                                          Expanded(
                                            flex: 2,
                                            child: TextAboveNumberedCircle(
                                                "Delivery requests",
                                                deliveriesList[index]
                                                    .requestedDeliveries,
                                                BROWN_MEDIUM),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 36,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
            ),
    );
  }
}
