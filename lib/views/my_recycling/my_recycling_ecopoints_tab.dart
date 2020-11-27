import 'package:econet/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: REEMPLAZAR ESTA CLASE POR LO QUE SE RECIBE DE LA API
class DeliverInformation {
  String residue;
  String timeRemaining;
  int pendingDeliveries;
  int requestedDeliveries;

  DeliverInformation(this.residue, this.timeRemaining, this.pendingDeliveries,
      this.requestedDeliveries);
}

class MyRecyclingEcopointsTab extends StatelessWidget {
  //DATOS HARDCODEADOS
  List<DeliverInformation> deliveriesList = [
    DeliverInformation("Paper", "6 days", 15, 4),
    DeliverInformation("batteries", "2 weeks", 2, 10),
  ];

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
        child: Column(
          children: List.generate(deliveriesList.length, (index) {
            return Container(
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      deliveriesList[index].residue,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GREEN_DARK,
                        fontSize: 22,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 72,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Due in",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontFamily: 'SFProDisplay',
                                  ),
                                ),
                              ),
                              Chip(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                label: Text(
                                  deliveriesList[index].timeRemaining,
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
                      ),
                      Spacer(),
                      Expanded(
                        flex: 2,
                        child: textAboveNumberedCircle(
                            "Pending deliveries",
                            deliveriesList[index].pendingDeliveries,
                            GREEN_DARK),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 2,
                        child: textAboveNumberedCircle(
                            "Delivery requests",
                            deliveriesList[index].requestedDeliveries,
                            BROWN_MEDIUM),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Icon(
                            Icons.chevron_right,
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget textAboveNumberedCircle(String text, int number, Color circleColor) {
    return Container(
      height: 75,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: 'SFProDisplay',
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 33,
            width: 33,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor,
            ),
            child: Text(
              number.toString(),
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
