import 'dart:convert';

import 'package:econet/model/ecopoint_delivery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class DeliveryProvider {
  Future<EcopointDelivery> getDelivery(String id);

  Future<List<EcopointDelivery>> getDeliveriesInEcopoint(String ecopointId);

  Future<List<EcopointDelivery>> getDeliveriesCustomFilter(
      Map<String, String> filters);

  Future<List<EcopointDelivery>> getDeliveriesOfUser(String email);

  Future<bool> createDelivery(EcopointDelivery delivery);

  Future<bool> updateDelivery(EcopointDelivery delivery);
}

final deliveryUrl =
    "https://us-central1-econet-8552d.cloudfunctions.net/delivery";

class FirebaseDeliveryProvider extends ChangeNotifier
    implements DeliveryProvider {
  @override
  Future<bool> createDelivery(EcopointDelivery delivery) async {
    final user = await FirebaseAuth.instance.currentUser;
    final token = await user.getIdToken();
    final email = await user.email;
    final response = await http.post("$deliveryUrl?email=$email",
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: delivery.toJson());

    return response.statusCode == 200;
  }

  @override
  Future<List<EcopointDelivery>> getDeliveriesCustomFilter(
      Map<String, String> filters) async {
    final user = await FirebaseAuth.instance.currentUser;
    final token = await user.getIdToken();
    final email = await user.email;
    String arguments;
    filters.forEach((key, value) {
      arguments += key + "=" + value + "&";
    });
    final response = await http.post("$deliveryUrl?$arguments", headers: {
      'Authorization': 'Bearer $token',
    });
    List list = jsonDecode(response.body);
    return list.map((e) => EcopointDelivery.fromJson(e));
  }

  @override
  Future<List<EcopointDelivery>> getDeliveriesInEcopoint(String ecopointId) {}

  @override
  Future<List<EcopointDelivery>> getDeliveriesOfUser(String email) {
    // TODO: implement getDeliveriesOfUser
    throw UnimplementedError();
  }

  @override
  Future<EcopointDelivery> getDelivery(String id) {
    // TODO: implement getDelivery
    throw UnimplementedError();
  }

  @override
  Future<bool> updateDelivery(EcopointDelivery delivery) {
    // TODO: implement updateDelivery
    throw UnimplementedError();
  }
}
