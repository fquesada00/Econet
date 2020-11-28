import 'package:econet/views/widgets/pending_delivery_card.dart';
import 'package:flutter/cupertino.dart';

class MyEcopointRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          PendingDeliveryCard("moniii1",12,"19 days"),
          PendingDeliveryCard("moniii2",2,"2 days"),
          PendingDeliveryCard("moniii3",6,"3 hours"),
          PendingDeliveryCard("moniii4",3,"50 minutes"),
          PendingDeliveryCard("moniii5",3,"4 days"),
        ],
      ),
    );
  }
}