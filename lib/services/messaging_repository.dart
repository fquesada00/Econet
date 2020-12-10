import 'dart:convert';

import 'package:econet/model/ecopoint_delivery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class MessagingProvider implements ChangeNotifier {
  Future<bool> sendMessage(String email, Map<String,dynamic> message);
  Future<bool> createDevice();
  Future<bool> deleteDevice();
}

final messageUrl =
    "https://us-central1-econet-8552d.cloudfunctions.net/message";
final deviceUrl =
    "https://us-central1-econet-8552d.cloudfunctions.net/device";

class FirebaseMessagingProvider extends MessagingProvider with ChangeNotifier {

  @override
  Future<bool> sendMessage(String email, Map<String, dynamic > message) async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user.getIdToken();
    final response = await http.post("$messageUrl?email=$email",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(message));
    return response.statusCode == 200;
  }

  @override
  Future<bool> createDevice() async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user.getIdToken();
    final fcm = FirebaseMessaging.instance.getToken();
    final response = await http.post("$messageUrl?fcm=$fcm",
        headers: {
          'Authorization': 'Bearer $token',
        });
    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteDevice() async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user.getIdToken();
    final fcm = FirebaseMessaging.instance.getToken();
    final response = await http.delete("$messageUrl?fcm=$fcm",
        headers: {
          'Authorization': 'Bearer $token',
        });
    return response.statusCode == 200;
  }
}
