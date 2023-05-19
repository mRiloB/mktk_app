import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MkTkAPI {
  MkTkAPI() {
    setConfigurations();
  }
  String username = '';
  String password = '';
  String ip = '';
  String baseUrl = '';

  String getBasicAuth() {
    return "Basic ${base64.encode(utf8.encode('$username:$password'))}";
  }

  Map<String, String> getHeaders() {
    return {
      'Authorization': getBasicAuth(),
      'Content-Type': 'application/json'
    };
  }

  // função que roda o comando de listar users (vouchers)
  Future<dynamic> cmdPrint(String cmd) async {
    final response =
        await http.get(Uri.parse('$baseUrl/$cmd'), headers: getHeaders());
    debugPrint('STATUS: ${response.statusCode.toString()}');

    if (response.statusCode == 200) {
      debugPrint('=== BODY: ${response.body}');
      return response.body;
    }
  }

  // função que roda o comando de adicionar users (vouchers)
  void cmdAdd(Map<String, String> payload) async {
    final response = await http.put(Uri.parse('$baseUrl/ip/hotspot/user'),
        body: jsonEncode(payload), headers: getHeaders());
    debugPrint('=== STATUS: ${response.statusCode.toString()}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('=== BODY: ${response.body}');
      debugPrint('=== VOUCHER DE 1H CRIADO');
      return;
    }
  }

  void setConfigurations() {
    final LocalStorage storage = LocalStorage('configuration.json');
    try {
      Map<String, String> config = storage.getItem('config');
      username = config['user']!;
      password = config['password']!;
      ip = config['ip']!;
      baseUrl = 'https://$ip/rest';
      debugPrint("=== SET CONFIG: $ip | $username | $password | $baseUrl");
    } catch (e) {
      debugPrint("=== API SET CONFIG ERROR: ${e.toString()}");
    }
  }
}
