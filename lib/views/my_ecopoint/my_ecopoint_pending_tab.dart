import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/services/delivery_repository.dart';
import 'package:econet/views/widgets/delivery_card.dart';
import 'package:flutter/cupertino.dart';

class MyEcopointPendingTab extends StatefulWidget {
  Ecopoint ecopoint;
  MyEcopointPendingTab(this.ecopoint);

  @override
  _MyEcopointPendingTabState createState() => _MyEcopointPendingTabState();
}

class _MyEcopointPendingTabState extends State<MyEcopointPendingTab> {
  DeliveryProvider deliveryRepository;

  List<EcopointDelivery> ecopointsList = [
    // TODO: RECIBIR ESTOS DATOS DE LA API
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
          children: List.generate(
              ecopointsList.length,
              (index) => DeliveryCard(
                  ecopointsList[index], "/pending_delivery_details"))),
    );
  }
}
