import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mktk_app/src/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class APIModel {
  final Uri url;
  final Map<String, String> headers;

  APIModel({required this.url, required this.headers});
}

class MkTkAPI {
  static Future<APIModel> apiConfig(String cmd) async {
    Boat boat = await BoatController().getLocalBoat();
    return APIModel(
      url: Uri.parse('https://${boat.connectionIp}/rest$cmd'),
      headers: {
        'Authorization':
            'Basic ${base64.encode(utf8.encode(boat.connectionUser!))}',
        'Content-Type': 'application/json',
      },
    );
  }

  static Future<dynamic> cmdPrint(String cmd) async {
    APIModel api = await MkTkAPI.apiConfig(cmd);
    final response = await http.get(
      api.url,
      headers: api.headers,
    );
    String body = response.body;
    int status = response.statusCode;
    debugPrint('=== BODY $status: $body');
    return jsonDecode(body);
  }
}
