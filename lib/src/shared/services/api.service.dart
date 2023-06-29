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
  String cmd;

  MkTkAPI(this.cmd) {
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
        baseUrl = 'https://$ip/rest$cmd';
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
      'Content-Type': 'application/json',
    };
  }

  // função que roda o comando de listar
  Future<dynamic> cmdPrint() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: getHeaders(),
    );
    String body = response.body;
    int status = response.statusCode;
    debugPrint('=== BODY $status: $body');
    return jsonDecode(body);
  }

  // função que roda o comando de adicionar
  Future<dynamic> cmdAdd(Map<String, dynamic> payload) async {
    String reqBody = jsonEncode(payload);
    debugPrint('=== PAYLOAD: $reqBody');
    final response = await http.put(
      Uri.parse(baseUrl),
      body: reqBody,
      headers: getHeaders(),
    );
    String resBody = response.body;
    int status = response.statusCode;
    debugPrint('=== BODY $status: $resBody');
    return status;
    // if (status == 200 || status == 201) {
    //   return {
    //     'ok': true,
    //     'data': jsonDecode(resBody).cast<Map<String, dynamic>>(),
    //   };
    // } else if (status == 400) {
    //   return {
    //     'ok': false,
    //     'data': jsonDecode(resBody).cast<Map<String, dynamic>>(),
    //   };
    // }
  }

  // função que roda o comando de remover
  Future<dynamic> cmdRemove(String id) async {
    debugPrint('DELETE [$baseUrl/$id]: $id');
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: getHeaders(),
    );
    String resBody = response.body;
    int status = response.statusCode;
    debugPrint('=== BODY $status: $resBody');
  }
}
