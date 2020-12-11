import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/delivery_repository.dart';
import 'package:econet/views/widgets/delivery_info_list.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDeliveryDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EcopointDelivery ecopointDelivery =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GREEN_LIGHT,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: NavBar(
              text: ecopointDelivery.ecopoint.name,
              withBack: true,
              backgroundColor: GREEN_LIGHT,
              textColor: GREEN_DARK,
              rightIcon: Icons.delete_forever,
              onPressedRightIcon: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("CONFIRM DELETE"),
                          content: Text("You cant undo this action"),
                          actions: [
                            FlatButton(
                              onPressed: () async {
                                DeliveryProvider deliveryRepository =
                                    Provider.of<DeliveryProvider>(context,
                                        listen: false);
                                await deliveryRepository
                                    .deleteDelivery(ecopointDelivery.id);
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home_econet',
                                    ModalRoute.withName('/landing'));
                              },
                              child: Text("Confirm"),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text("Cancel"),
                            ),
                          ],
                        ));
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DeliveryInfoList(ecopointDelivery, GREEN_DARK),
            ),
          ),
        ],
      ),
    );
  }
}
