import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/services/delivery_repository.dart';
import 'package:econet/views/widgets/delivery_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyEcopointRequestsTab extends StatefulWidget {
  Ecopoint ecopoint;

  MyEcopointRequestsTab(this.ecopoint);

  @override
  _MyEcopointRequestsTabState createState() => _MyEcopointRequestsTabState();
}

class _MyEcopointRequestsTabState extends State<MyEcopointRequestsTab> {
  DeliveryProvider deliveryRepository;
  bool loading = true;
  List<EcopointDelivery> requestsList = [];

  Future<void> fillRequests() async {
    await deliveryRepository
        .getDeliveriesInEcopoint(widget.ecopoint.id)
        .then((deliveries) {
      deliveries.forEach((delivery) {
        print("ELEMENTO = " + delivery.toString());
        if (!delivery.isConfirmed) {
          requestsList.add(delivery);
        }
      });
      loading = false;
      setState(() {});
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
    if (loading)
      return Center(child: CircularProgressIndicator());
    else if (requestsList.length == 0)
      return Center(
        child: Text(
          "No requested deliveries available",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: 'SFProDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    else
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
