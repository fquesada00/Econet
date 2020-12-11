import 'dart:convert';

import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/services/messaging_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class DeliveryProvider implements ChangeNotifier {
  Future<EcopointDelivery> getDelivery(String id);

  Future<List<EcopointDelivery>> getDeliveriesInEcopoint(String ecopointId);

  Future<List<EcopointDelivery>> getDeliveriesCustomFilter(
      Map<String, String> filters);

  Future<List<EcopointDelivery>> getDeliveriesOfUser(String email);

  Future<bool> createDelivery(EcopointDelivery delivery);

  Future<bool> updateDelivery(EcopointDelivery delivery);

  Future<bool> deleteDelivery(String deliveryId);
}

final deliveryUrl =
    "https://us-central1-econet-8552d.cloudfunctions.net/delivery";

class FirebaseDeliveryProvider extends DeliveryProvider with ChangeNotifier {
  @override
  Future<bool> createDelivery(EcopointDelivery delivery) async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user.getIdToken();
    final email = user.email;
    print(delivery.toJson());
    final response = await http.post("$deliveryUrl?email=$email",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(delivery));
    if (response.statusCode == 200) {
      FirebaseMessagingProvider()
          .sendMessage(delivery.ecopoint.ecollector.email, {
        "notification": {
          "title": "New Delivery!",
          "body":
              "created by ${delivery.user.fullName} for delivering ${delivery.date.day}/${delivery.date.month}/${delivery.date.year}"
        },
        "data": {"delivery": jsonEncode(delivery.toJson())}
      });
      return true;
    } else
      return false;
  }

  @override
  Future<List<EcopointDelivery>> getDeliveriesCustomFilter(
      Map<String, String> filters) async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user.getIdToken();
    String arguments = "";
    filters.forEach((key, value) {
      arguments += key + "=" + value + "&";
    });
    final response = await http.get("$deliveryUrl?$arguments", headers: {
      'Authorization': 'Bearer $token',
    });
    List list = jsonDecode(response.body);
    return list.map((e) => EcopointDelivery.fromJson(e)).toList();
  }

  @override
  Future<List<EcopointDelivery>> getDeliveriesInEcopoint(String ecopointId) {
    return getDeliveriesCustomFilter({'ecopointId': ecopointId});
  }

  @override
  Future<List<EcopointDelivery>> getDeliveriesOfUser(String email) {
    return getDeliveriesCustomFilter({'email': email});
  }

  @override
  Future<EcopointDelivery> getDelivery(String id) {
    return getDeliveriesCustomFilter({'id': id}).then((value) => value.first);
  }

  @override
  Future<bool> updateDelivery(EcopointDelivery delivery) async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user.getIdToken();
    final email = user.email;
    final response =
        await http.put("$deliveryUrl?email=$email&deliveryId=${delivery.id}",
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(delivery));

    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteDelivery(String deliveryId) async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user.getIdToken();
    final email = user.email;
    final response = await http
        .delete("$deliveryUrl?email=$email&deliveryId=$deliveryId", headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200)
      print("DELIVERY BORRADO");
    else
      print("DELIVERY NO BORRADO, error: " + response.statusCode.toString());

    return response.statusCode == 200;
  }
}
