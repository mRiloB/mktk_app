import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/storage/configuration/connection.storage.dart';
import 'package:mktk_app/src/vouchers/widgets/create_btn.dart';
import 'package:mktk_app/src/vouchers/widgets/header.dart';

class VouchersPage extends StatefulWidget {
  const VouchersPage({super.key});

  @override
  State<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  bool isConfig = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    try {
      List<Map<String, dynamic>> connStorage =
          await ConnectionStorage.getConnection();
      setState(() {
        isConfig = connStorage.isNotEmpty;
      });
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
              CreateBtn(),
            ],
          )
        : const Center(
            child: Text("Faça a configuração do aplicativo."),
          );
  }
}
