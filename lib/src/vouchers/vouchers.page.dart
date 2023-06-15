import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/connection.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/configuration.hive.dart';
import 'package:mktk_app/src/vouchers/widgets/header.dart';

class VouchersPage extends StatefulWidget {
  const VouchersPage({super.key});

  @override
  State<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  ConfigurationCollection configCollection = ConfigurationCollection();
  bool isConfig = false;

  @override
  void initState() {
    super.initState();
    try {
      Connection conn = configCollection.getConnection() ?? Connection();
      isConfig = !conn.isEmpty;
    } catch (e) {
      debugPrint('=== VOUCHERS PAGE INIT: ${e.toString()}');
    }
  }

  // void _messageBox(String text) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(text),
  //       action: SnackBarAction(
  //         label: 'Fechar',
  //         onPressed: () {},
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return isConfig
        ? const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Header(),
              Text('Em Desenvolvimento...'),
            ],
          )
        : const Center(
            child: Text("Faça a configuração do aplicativo."),
          );
  }
}
