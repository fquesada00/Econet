import 'package:econet/model/bag.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/model/timerange.dart';
import 'package:econet/presentation/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRecyclingDeliveriesTab extends StatelessWidget {
  List<EcopointDelivery> ecopointsList = [
    // TODO: RECIBIR ESTOS DATOS DE LA API
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
          children: List.generate(ecopointsList.length, (index) {
            return Container(
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
                          ecopointsList[index].user.fullName + "'s Ecopoint",
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
                                ecopointsList[index].date),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/my_delivery_details',
                            arguments: ecopointsList[index]);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.chevron_right,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
