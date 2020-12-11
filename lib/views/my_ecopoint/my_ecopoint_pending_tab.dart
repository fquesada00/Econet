import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/services/delivery_repository.dart';
import 'package:econet/views/widgets/delivery_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyEcopointPendingTab extends StatefulWidget {
  Ecopoint ecopoint;

  MyEcopointPendingTab(this.ecopoint);

  @override
  _MyEcopointPendingTabState createState() => _MyEcopointPendingTabState();
}

class _MyEcopointPendingTabState extends State<MyEcopointPendingTab> {
  DeliveryProvider deliveryRepository;
  bool loading = true;
  List<EcopointDelivery> pendingsList = [];

  Future<void> fillPendings() async {
    await deliveryRepository
        .getDeliveriesInEcopoint(widget.ecopoint.id)
        .then((deliveries) {
      deliveries.forEach((delivery) {
        print("ELEMENTO = " + delivery.toString());
        if (!delivery.finished &&
            delivery.isConfirmed &&
            delivery.responseValue) {
          pendingsList.add(delivery);
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
    fillPendings();
  }

  @override
  Widget build(BuildContext context) {
    if (loading)
      return Center(child: CircularProgressIndicator());
    else if (pendingsList.length == 0)
      return Center(
        child: Text(
          "No pending deliveries available",
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
                pendingsList.length,
                (index) => DeliveryCard(
                    pendingsList[index], "/pending_delivery_details"))),
      );
  }
}
