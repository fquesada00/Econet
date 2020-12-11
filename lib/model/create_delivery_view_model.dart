import 'package:flutter/material.dart';

import 'bag.dart';
import 'ecopoint.dart';

class CreateDeliveryModel {
  CreateDeliveryModel._privateConstructor();

  static final CreateDeliveryModel _instance =
      CreateDeliveryModel._privateConstructor();

  static CreateDeliveryModel get instance => _instance;

  Ecopoint ecopoint;
  DateTime deliveryDate;
  TimeOfDay deliveryTime;
  List<Bag> bags;

  void reset() {
    deliveryDate = null;
    deliveryTime = null;
    bags = null;
    ecopoint = null;
  }
}
