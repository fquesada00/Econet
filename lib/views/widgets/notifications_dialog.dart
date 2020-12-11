import 'dart:convert';

import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/model/residue.dart';
import 'package:econet/model/timerange.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NotificationsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        children: <Widget>[
          NotificationBar(),
          SizedBox(
            height: 15,
          ),
          NotificationBox(),
        ],
      ),
    );
  }
}

class NotificationBox extends StatefulWidget {
  @override
  _NotificationBoxState createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  List<EcopointDelivery> pendingDeliveries = [];
  bool init = false;
  @override
  Widget build(BuildContext context) {

    if(!init) {
      init=true;
      var readCache = () async {
        try {
          List<dynamic> list = (await Cache.read(
              "notifications_deliveries"))['data'];
          pendingDeliveries =
              list.map((e) => EcopointDelivery.fromJson(jsonDecode(e)))
                  .toList();
        } catch (e) {
          print(e);
        }
        setState(() {});
      };
      readCache();
      Cache.addListener("notifications_deliveries", readCache);
    }

    return Container(
      padding: EdgeInsets.all(10),
      height: 450,
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
        borderRadius: BorderRadius.circular(25),
      ),
      child: (pendingDeliveries.length == 0)
          ? Container(
              child: Text(
                "No pending deliveries",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'SFProDisplay',
                ),
              ),
            )
          : ListView(
              children: List.generate(
                pendingDeliveries.length,
                (index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: 290,
                    height: 90,
                    decoration: BoxDecoration(
                      color: GREEN_LIGHT,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Icon(
                                    Icons.calendar_today,
                                    size: 45,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Center(
                                    child: Text(
                                      "Deliver to " +
                                          pendingDeliveries[index]
                                              .user
                                              .fullName +
                                          " in " +
                                          TimeRange.getRemainingDeliverTime(
                                              pendingDeliveries[index].date),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'SFProDisplay',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class NotificationBar extends StatelessWidget {
  final BorderRadius _BORDER_RADIUS = BorderRadius.circular(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
        color: BROWN_MEDIUM,
        borderRadius: _BORDER_RADIUS,
      ),
      child: Row(
        children: <Widget>[
          Spacer(),
          Text(
            "Notifications",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.notifications,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
