import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/services/delivery_repository.dart';
import 'package:econet/views/widgets/delivery_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MyEcopointRequestsTab extends StatefulWidget {
  Ecopoint ecopoint;
  MyEcopointRequestsTab(this.ecopoint);

  @override
  _MyEcopointRequestsTabState createState() => _MyEcopointRequestsTabState();
}

class _MyEcopointRequestsTabState extends State<MyEcopointRequestsTab> {
  DeliveryProvider deliveryRepository;

  List<EcopointDelivery> requestsList = [];

  Future<void> fillRequests() async {
    await deliveryRepository
        .getDeliveriesInEcopoint(widget.ecopoint.id)
        .then((deliveries) {
      deliveries.forEach((delivery) {
        print("ELEMENTO = " + delivery.toString());
        if (!delivery.finished && !delivery.responseValue) {
          requestsList.add(delivery);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    deliveryRepository = Provider.of<DeliveryProvider>(context, listen: false);
    fillRequests();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
          children: List.generate(
              requestsList.length,
              (index) => DeliveryCard(
                  requestsList[index], "/request_delivery_details"))),
    );
  }
}
