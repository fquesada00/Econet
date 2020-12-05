import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/delivery_info_list.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EcopointDelivery ecopointDelivery =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: BROWN_LIGHT,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: NavBar(
              text: ecopointDelivery.user.fullName,
              withBack: true,
              backgroundColor: BROWN_LIGHT,
              textColor: BROWN_DARK,
              rightIcon: Icons.delete_forever,
              onPressedRightIcon: () {
                print("BORRARRRRR");
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DeliveryInfoList(ecopointDelivery, BROWN_DARK),
            ),
          ),
        ],
      ),
    );
  }
}
