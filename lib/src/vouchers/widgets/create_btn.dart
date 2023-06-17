import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/profile.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/services/api.service.dart';
import 'package:mktk_app/src/shared/storage/configuration/profile.storage.dart';
import 'package:mktk_app/src/shared/storage/configuration/vouchers.storage.dart';

class CreateBtn extends StatefulWidget {
  const CreateBtn({super.key});

  @override
  State<CreateBtn> createState() => _CreateBtnState();
}

class _CreateBtnState extends State<CreateBtn> {
  bool isLoading = false;
  List<Map<String, dynamic>> profiles = [];
  String dropdownValue = '';
  MkTkAPI api = MkTkAPI('/ip/hotspot/user');

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
        dropdownValue =
            "${profiles.first['name']}|${profiles.first['limit_uptime']}|${profiles.first['price']}";
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

  Future<void> createVoucher(String voucherName) async {
    setState(() {
      isLoading = true;
    });
    try {
      List<String> profileInfo = dropdownValue.split('|');
      Voucher newVoucher = Voucher(
        name: voucherName,
        server: 'all',
        profile: profileInfo[0],
        limitUptime: profileInfo[1],
        price: double.parse(profileInfo[2]),
      );
      debugPrint('NEW VOUCHER: $newVoucher');
      List<Map<String, dynamic>> result =
          await VoucherStorage.getInfo(voucherName);
      debugPrint('PROFILES: $result');
      if (result.isEmpty) {
        await api.cmdAdd({
          "name": newVoucher.name,
          "server": newVoucher.server,
          "profile": newVoucher.profile,
          "limit-uptime": newVoucher.limitUptime,
        });
        await VoucherStorage.create(newVoucher);
      } else {
        await createVoucher(Voucher.generateVoucher());
      }
    } catch (e) {
      debugPrint('=== LOAD PROFILES CREATE BTN ERROR: ${e.toString()}');
      _messageBox(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> showVoucher(BuildContext context, [bool mounted = true]) async {
    final voucher = Voucher.generateVoucher();

    Widget cancelBtn = TextButton(
      child: const Text('Cancelar'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget createBtn = ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color(0xFF4758A9),
        ),
      ),
      child: const Text(
        'Confirmar',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        await createVoucher(voucher);
        if (!mounted) return;
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              voucher,
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
              margin: const EdgeInsets.only(top: 20.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                value: dropdownValue,
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  // debugPrint('OnChanged: $value');
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: profiles.map<DropdownMenuItem<String>>((el) {
                  // debugPrint('el: $el');
                  return DropdownMenuItem<String>(
                    value: "${el['name']}|${el['limit_uptime']}|${el['price']}",
                    child: Text("${el['name']} - \$${el['price']}"),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        cancelBtn,
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : createBtn,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
  Widget build(BuildContext context, [bool mounted = true]) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () async {
          await _loadProfiles();
          if (!mounted) return;
          await showVoucher(context);
        },
        child: const Card(
          color: Color(0xFF4758A9),
          child: SizedBox(
            width: double.infinity,
            height: 150.0,
            child: Center(
              child: Text(
                'Criar Voucher',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
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
            ),
          ),
        ),
      ),
    );
  }
}
