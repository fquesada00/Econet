import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/views/ecopoint/add_bags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'InformationCard.dart';
import 'button1.dart';
import 'ecollector_info.dart';

class DeliveryInfoList extends StatelessWidget {
  final EcopointDelivery ecopointDelivery;
  final Color backgroundColor;
  final bool editable;
  final bool isEcollector;

  DeliveryInfoList(this.ecopointDelivery, this.backgroundColor,
      {this.editable = true, this.isEcollector = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EcollectorInfo(ecopointDelivery.user.fullName, backgroundColor,
            isEcollector: isEcollector),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Button1(
            btnData: ButtonData(
              isEcollector ? 'CONTACT ECOLLECTOR' : 'CONTACT',
              () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("PHONE NUMBER"),
                    content: Text(
                      ecopointDelivery.ecopoint.ecollector.phone == null
                          ? 'No phone number available'
                          : ecopointDelivery.ecopoint.ecollector.phone,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'SFProDisplay',
                      ),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Ok"),
                      ),
                    ],
                  ),
                );
              },
              backgroundColor: backgroundColor,
              adjust: true,
              height: 50,
              width: 220,
              fontSize: 28,
            ),
          ),
        ),
        InformationCard(
          icon: Icons.room,
          name: "Ecopoint address",
          nameColor: backgroundColor,
          content: Text(
            ecopointDelivery.ecopoint.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'SFProDisplay',
            ),
          ),
          editable: false,
        ),
        InformationCard(
          icon: Icons.calendar_today,
          name: "Deliver scheduled for",
          nameColor: backgroundColor,
          content: Text(
            ecopointDelivery.date.toIso8601String().substring(0, 10),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w600,
            ),
          ),
          editable: editable,
        ),
        if (ecopointDelivery.bags != null)
          InformationCard(
            name: "Bags/Objects",
            nameColor: backgroundColor,
            content: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 330),
              child: ListView.separated(
                padding: EdgeInsets.all(15),
                itemCount: ecopointDelivery.bags.length,
                itemBuilder: (BuildContext context, int index) {
                  return BagInfoRow(ecopointDelivery.bags, index, true);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 8),
              ),
            ),
            editable: editable,
          ),
      ],
    );
  }
}
