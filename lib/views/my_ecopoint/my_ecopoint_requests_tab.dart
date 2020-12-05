import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/model/user.dart';
import 'package:econet/views/widgets/delivery_card.dart';
import 'package:flutter/cupertino.dart';

class MyEcopointRequestsTab extends StatelessWidget {
  List<EcopointDelivery> ecopointsList = [
    // TODO: RECIBIR ESTOS DATOS DE LA API
    EcopointDelivery(
        "PEPE",
        new DateTime(2020, 12, 12),
        [
          Bag(BagSize.large, BagWeight.light, 3),
          Bag(BagSize.small, BagWeight.heavy, 1),
          Bag(BagSize.medium, BagWeight.veryHeavy, 3)
        ],
        new User("pepe1pepe1pepe", "pepe@gmail.com", "", "0303456", true)),
    EcopointDelivery(
        "PEPE",
        new DateTime(2020, 12, 5),
        [
          Bag(BagSize.large, BagWeight.light, 3),
          Bag(BagSize.small, BagWeight.heavy, 1),
          Bag(BagSize.medium, BagWeight.veryHeavy, 3)
        ],
        new User("pepe2", "pepe@gmail.com", "", "0303456", true)),
    EcopointDelivery(
        "PEPE",
        new DateTime(2020, 11, 27, 18),
        [
          Bag(BagSize.large, BagWeight.light, 3),
          Bag(BagSize.small, BagWeight.heavy, 1),
          Bag(BagSize.medium, BagWeight.veryHeavy, 3)
        ],
        new User("pepe3", "pepe@gmail.com", "", "0303456", true)),
    EcopointDelivery(
        "PEPE",
        new DateTime(2020, 11, 27, 16),
        [
          Bag(BagSize.large, BagWeight.light, 3),
          Bag(BagSize.small, BagWeight.heavy, 1),
          Bag(BagSize.medium, BagWeight.veryHeavy, 3)
        ],
        new User("pepe4", "pepe@gmail.com", "", "0303456", true)),
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
