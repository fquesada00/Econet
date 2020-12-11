import 'dart:convert';

import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/delivery_repository.dart';
import 'package:econet/services/messaging_repository.dart';
import 'package:econet/views/widgets/delivery_info_list.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/positive_negative_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestDetails extends StatefulWidget {
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  bool _isLoading;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final EcopointDelivery ecopointDelivery =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: BROWN_LIGHT,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: NavBar(
                    text: ecopointDelivery.user.fullName,
                    withBack: true,
                    backgroundColor: BROWN_LIGHT,
                    textColor: BROWN_DARK,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 100),
                        //tamanio del widget inferior
                        child: DeliveryInfoList(
                          ecopointDelivery,
                          BROWN_DARK,
                          isEcollector: false,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: PositiveNegativeButtons("Accept", "Reject", () {
                          _isLoading = true;
                          setState(() {});

                          FirebaseMessagingProvider()
                              .sendMessage(ecopointDelivery.user.email, {
                            "notification": {
                              "title": "Confirmed delivery!",
                              "body":
                                  "Your request for delivering your residues to ${ecopointDelivery.ecopoint.name} has been approved"
                            },
                            "data": {
                              "delivery": jsonEncode(ecopointDelivery.toJson())
                            }
                          });
                          ecopointDelivery.isConfirmed = true;
                          ecopointDelivery.responseValue = true;
                          FirebaseDeliveryProvider()
                              .updateDelivery(ecopointDelivery)
                              .then((value) {
                            if (value) {
                              Navigator.of(context).pop();
                            } else {
                              _isLoading = false;
                              setState(() {});
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Center(
                                  heightFactor: 1,
                                  child: Text(
                                    "Error while accepting delivery. Make sure you have an internet connection",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ));
                            }
                          });
                        }, () {
                          _isLoading = true;
                          setState(() {});

                          FirebaseMessagingProvider()
                              .sendMessage(ecopointDelivery.user.email, {
                            "notification": {
                              "title": "Your delivery has been rejected",
                              "body":
                                  "Your request for delivering your residues to ${ecopointDelivery.ecopoint.name} has been rejected"
                            },
                            "data": {
                              "delivery": jsonEncode(ecopointDelivery.toJson())
                            }
                          });
                          ecopointDelivery.isConfirmed = true;
                          ecopointDelivery.responseValue = false;
                          FirebaseDeliveryProvider()
                              .updateDelivery(ecopointDelivery)
                              .then((value) {
                            if (value) {
                              Navigator.of(context).pop();
                            } else {
                              _isLoading = false;
                              setState(() {});
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Center(
                                  heightFactor: 1,
                                  child: Text(
                                    "Error while rejecting delivery. Make sure you have an internet connection",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ));
                            }
                          });
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
