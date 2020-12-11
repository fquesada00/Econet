import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/model/timerange.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/delivery_repository.dart';
import 'package:econet/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRecyclingDeliveriesTab extends StatefulWidget {
  @override
  _MyRecyclingDeliveriesTabState createState() =>
      _MyRecyclingDeliveriesTabState();
}

class _MyRecyclingDeliveriesTabState extends State<MyRecyclingDeliveriesTab> {
  List<EcopointDelivery> deliveriesList = [];
  String currentUserEmail;
  bool loadingDeliveries = true;

  @override
  void initState() {
    super.initState();
    getInformation();
  }

  fillDeliveries() async {
    DeliveryProvider deliveryRepository =
        Provider.of<DeliveryProvider>(context, listen: false);
    await deliveryRepository
        .getDeliveriesOfUser(currentUserEmail)
        .then((deliveries) {
      deliveries.forEach((delivery) {
        print("ELEMENTO = " + delivery.toString());
        deliveriesList.add(delivery);
      });
    });
    loadingDeliveries = false;
    setState(() {});
  }

  getInformation() async {
    AuthProvider provider =
        await Provider.of<AuthProvider>(context, listen: false);

    await provider.getCurrentUser().then((value) {
      currentUserEmail = value.email;
    });
    fillDeliveries();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: GREEN_MEDIUM,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 15),
        child: (loadingDeliveries || deliveriesList.isEmpty)
            ? Container(
                height: 100,
                child: Center(
                  child: (!loadingDeliveries)
                      ? Text(
                          "No deliveries available",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : CircularProgressIndicator(),
                ),
              )
            : Column(
                children: List.generate(deliveriesList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/my_delivery_details',
                          arguments: deliveriesList[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Text(
                                  deliveriesList[index].user.fullName +
                                      "'s Ecopoint",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: GREEN_DARK,
                                    fontSize: 22,
                                    fontFamily: 'SFProDisplay',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.0),
                                  child: Text(
                                    "Due in",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'SFProDisplay',
                                    ),
                                  ),
                                ),
                                Chip(
                                  label: Text(
                                    TimeRange.getRemainingDeliverTime(
                                        deliveriesList[index].date),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'SFProDisplay',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  backgroundColor: BROWN_DARK,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.chevron_right,
                                size: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
      ),
    );
  }
}
