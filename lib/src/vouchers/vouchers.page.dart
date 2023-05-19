import 'package:flutter/material.dart';
import 'package:mktk_app/controllers/api.dart';
import 'package:mktk_app/src/vouchers/widgets/voucher_btn.dart';
import 'package:mktk_app/controllers/create_user.dart';
import 'package:localstorage/localstorage.dart';

class VouchersPage extends StatefulWidget {
  const VouchersPage({super.key});

  @override
  State<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  MkTkAPI api = MkTkAPI();
  MkTkUser user = MkTkUser();
  final LocalStorage storage = LocalStorage('configuration.json');
  // final LocalStorage storageVoucher = LocalStorage('voucher_user.json');
  bool isConfigured = false;

  @override
  void initState() {
    super.initState();
    try {
      bool isConfigLS = storage.getItem('isConfig');
      if (isConfigLS) {
        isConfigured = isConfigLS;
      }
      // _clearStorage();
    } catch (e) {
      debugPrint('=== VOUCHERS PAGE INIT ERROR: ${e.toString()}');
    }
  }

  // void _clearStorage() async {
  //   await storageVoucher.clear();
  //   _messageBox('Voucher storage limpo!');
  // }

  void _createVoucher(String profile) async {
    try {
      api.setConfigurations();
      Map<String, String> userPass = await user.getUserAndPassword();
      String limitUptime = user.getLimitUptime(profile);
      Map<String, String> payload = {
        "name": userPass["user"]!,
        "password": userPass["password"]!,
        "server": "hotspot1",
        "profile": profile,
        "limit-uptime": limitUptime
      };
      api.cmdAdd(payload);
      debugPrint("=== VOUCHER CRIADO: $payload");
      _messageBox('Voucher criado!');
    } catch (e) {
      debugPrint("=== CREATE VOUCHER ERROR: ${e.toString()}");
    }
  }

  void _messageBox(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isConfigured
        ? GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: <Widget>[
                VoucherBtn(title: "1H", onPressed: () => _createVoucher('1h')),
                VoucherBtn(title: "5H", onPressed: () => _createVoucher('5h')),
                VoucherBtn(
                    title: "Viagem Completa",
                    onPressed: () => _createVoucher('Completa')),
              ])
        : const Center(
            child: Text("Faça a configuração do aplicativo."),
          );
  }
}
