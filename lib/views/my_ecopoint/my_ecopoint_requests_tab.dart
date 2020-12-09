import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/views/widgets/delivery_card.dart';
import 'package:flutter/cupertino.dart';

class MyEcopointRequestsTab extends StatelessWidget {
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
                  ecopointsList[index], "/request_delivery_details"))),
    );
  }
}
