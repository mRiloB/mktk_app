import 'package:flutter/material.dart';
import 'dart:math';
import 'package:localstorage/localstorage.dart';

class MkTkUser {
  MkTkUser();
  final LocalStorage storage = LocalStorage('voucher_user.json');
  final LocalStorage storageConfig = LocalStorage('configuration.json');
  List<int> lastUser = [];
  Future<List<int>> generateUser() async {
    dynamic userStorage = storage.getItem('lastUser');
    if (userStorage == null) {
      lastUser = [65, 65, 65, 64];
    } else {
      lastUser = userStorage["user"]!;
    }

    int a = lastUser[0];
    int b = lastUser[1];
    int c = lastUser[2];
    int d = lastUser[3];

    d++;
    if (d == 91) {
      c++;
      d = 65;
    } else if (c == 91) {
      b++;
      c = 65;
    } else if (b == 91) {
      a++;
      b = 65;
    } else if (a == 91) {
      return [45, 45, 45, 45];
    }

    lastUser = [a, b, c, d];
    await storage.setItem('lastUser', {"user": lastUser});
    return lastUser;
  }

  String generatePassword() {
    const length = 6;
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    // const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    // const special = '@#*?!=+';

    String chars = "";
    chars += letterLowerCase;
    chars += number;
    // chars += special;

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  List<String> asciiCode(List<int> data) {
    return [
      String.fromCharCode(data[0]),
      String.fromCharCode(data[1]),
      String.fromCharCode(data[2]),
      String.fromCharCode(data[3])
    ];
  }

  String getLimitUptime(String profile) {
    String ret = "";
    Map<String, String> config = storageConfig.getItem('config');
    if (profile == '1h') ret = "01:00:00";
    if (profile == '5h') ret = "05:00:00";
    if (profile == 'Viagem-Completa') ret = config["limit-uptime"]!;
    return ret;
  }

  Future<Map<String, String>> getUserAndPassword() async {
    List<int> user = await generateUser();
    String asciiUser = asciiCode(user).join("");
    String password = generatePassword();
    debugPrint("=== USER & PASSWORD: $asciiUser | $password");
    return {'user': asciiUser, 'password': password};
  }
}
