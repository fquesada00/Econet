import 'package:econet/views/widgets/pending_delivery_card.dart';
import 'package:flutter/cupertino.dart';

class MyEcopointPendingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          PendingDeliveryCard("pepepee1",12,"19 days"),
          PendingDeliveryCard("pepepee2",2,"2 days"),
          PendingDeliveryCard("pepepee3",6,"3 hours"),
          PendingDeliveryCard("pepepee4",3,"50 minutes"),
          PendingDeliveryCard("pepepee5",3,"4 days"),
        ],
      ),
    );
  }
}