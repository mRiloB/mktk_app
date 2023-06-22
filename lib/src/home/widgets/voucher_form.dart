import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/profile.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/services/api.service.dart';
import 'package:mktk_app/src/shared/storage/configuration/profile.storage.dart';
import 'package:mktk_app/src/shared/storage/configuration/vouchers.storage.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';

class VoucherForm extends StatefulWidget {
  final String voucher;

  const VoucherForm({
    super.key,
    required this.voucher,
  });

  @override
  State<VoucherForm> createState() => _VoucherFormState();
}

class _VoucherFormState extends State<VoucherForm> {
  bool isLoading = false;
  List<Map<String, dynamic>> profiles = [];
  String dropdownValue = '';
  MkTkAPI api = MkTkAPI('/ip/hotspot/user');

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> result = await ProfileStorage.getInfo(true);
      setState(() {
        profiles = result.map((e) {
          return Profile(
            id: e['id'],
            mktkId: e['mktk_id'],
            name: e['name'],
            limitUptime: e['limit_uptime'],
            price: e['price'],
          ).toMap();
        }).toList();
        dynamic aux = profiles.first;
        dynamic name = aux['name'],
            limitUptime = aux['limit_uptime'],
            price = aux['price'];
        dropdownValue = "$name|$limitUptime|$price";
      });
    } catch (e) {
      debugPrint('=== LOAD PROFILES CREATE BTN ERROR: ${e.toString()}');
      _messageBox(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createVoucher() async {
    String voucher = widget.voucher;

    setState(() {
      isLoading = true;
    });

    try {
      List<String> profileInfo = dropdownValue.split('|');
      Voucher newVoucher = Voucher(
        name: voucher,
        server: 'all',
        profile: profileInfo[0],
        limitUptime: profileInfo[1],
        price: double.parse(profileInfo[2]),
        createdAt: DateTime.timestamp().toString(),
      );
      debugPrint('NEW VOUCHER: $newVoucher');
      await api.cmdAdd({
        "name": newVoucher.name,
        "server": newVoucher.server,
        "profile": newVoucher.profile,
        "limit-uptime": newVoucher.limitUptime,
      });
      await VoucherStorage.create(newVoucher);
    } catch (e) {
      debugPrint('=== CREATE VOUCHER ERROR: ${e.toString()}');
      _messageBox(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> awaitTestFunction() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isLoading = false;
    });
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

  Widget cancelBtn() => TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancelar'),
      );

  Widget createBtn() => ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Color(0xFF4758A9),
          ),
        ),
        onPressed: ([bool mounted = true]) async {
          await createVoucher();
          // await awaitTestFunction();
          if (!mounted) return;
          Navigator.pop(context);
        },
        child: const Text(
          'Confirmar',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.voucher,
              style: const TextStyle(
                  fontSize: 40.0,
                  color: Color(0xFF4758A9),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                  height: 1.4,
                  overflow: TextOverflow.ellipsis,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 2.0,
                    ),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                value: dropdownValue,
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: profiles.map<DropdownMenuItem<String>>((el) {
                  // debugPrint('el: $el');
                  dynamic name = el['name'],
                      limitUptime = el['limit_uptime'],
                      price = el['price'];
                  return DropdownMenuItem<String>(
                    value: "$name|$limitUptime|$price",
                    child: Text("$name"),
                  );
                }).toList(),
              ),
            ),
            Text('Preço: ${dropdownValue.split('|').last}'),
            isLoading
                ? Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: const Loader(),
                  )
                : Container(),
          ],
        ),
      ),
      actions: [
        cancelBtn(),
        createBtn(),
      ],
    );
  }
}
