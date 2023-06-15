import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/storage/configuration/connection.storage.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MkTkAPI {
  String baseUrl = '';
  String ip = '';
  String login = '';
  String password = '';

  MkTkAPI() {
    setConfigurations();
  }

  void setConfigurations() async {
    try {
      List<Map<String, dynamic>> conn = await ConnectionStorage.getConnection();
      if (conn.isNotEmpty) {
        Map<String, dynamic> aux = conn[0];
        ip = aux['ip'];
        login = aux['login'];
        password = aux['password'];
        baseUrl = 'https://$ip/rest';
        debugPrint("=== SET CONFIG: $ip | $login | $password | $baseUrl");
      }
    } catch (e) {
      debugPrint("=== API SET CONFIG ERROR: ${e.toString()}");
    }
  }

  String getBasicAuth() {
    return "Basic ${base64.encode(utf8.encode('$login:$password'))}";
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
    debugPrint('=== BODY ${response.statusCode}: ${response.body}');
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  // função que roda o comando de adicionar users (vouchers)
  void cmdAdd(String cmd, Map<String, dynamic> payload) async {
    final response = await http.put(Uri.parse('$baseUrl$cmd'),
        body: jsonEncode(payload), headers: getHeaders());
    debugPrint('=== BODY ${response.statusCode}: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    }
  }
}
