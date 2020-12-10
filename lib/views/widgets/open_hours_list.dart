import 'package:econet/model/timeslot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpenHoursList extends StatelessWidget {
  List<TimeSlot> timeSlots;

  OpenHoursList({this.timeSlots});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.from(
        timeSlots
            .map((e) => Container(
                  margin: EdgeInsets.only(top: 3, bottom: 3, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          e.toStringDay() + ": ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              e.toStringRanges(),
                              maxLines: 5,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'SFProDisplay',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
