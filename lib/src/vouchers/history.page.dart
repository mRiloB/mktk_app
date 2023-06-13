import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class VouchersHistoryPage extends StatelessWidget {
  const VouchersHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = LocalStorage('history.json');
    List<Map<String, dynamic>> vouchers = [];
    try {
      vouchers = storage.getItem('vouchers');
    } catch (e) {
      debugPrint('=== LOAD HISTORY ERROR: ${e.toString()}');
    }

    return ListView(
        padding: const EdgeInsets.all(20),
        children: vouchers
            .map(
              (e) => Column(
                children: [
                  Text("user: ${e['name']}"),
                  Text("senha: ${e['password']}"),
                  Text("profile: ${e['profile']}"),
                  const Divider()
                ],
              ),
            )
            .toList());
  }
}
