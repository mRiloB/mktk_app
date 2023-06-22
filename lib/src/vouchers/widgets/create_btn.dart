import 'package:flutter/material.dart';
import 'package:mktk_app/src/home/widgets/voucher_form.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/vouchers.storage.dart';
import 'package:mktk_app/src/shared/widgets/default_btn.dart';

class CreateBtn extends StatefulWidget {
  const CreateBtn({super.key});

  @override
  State<CreateBtn> createState() => _CreateBtnState();
}

class _CreateBtnState extends State<CreateBtn> {
  bool isLoading = false;

  Future<void> createVoucher(BuildContext context,
      [bool mounted = true]) async {
    String voucher = Voucher.generateVoucher();
    List<Map<String, dynamic>> result = await VoucherStorage.getInfo(voucher);
    debugPrint('PROFILES: $result');
    if (!mounted) return;
    if (result.isEmpty) {
      await showVoucher(context, voucher);
    } else {
      await createVoucher(context);
    }
  }

  Future<void> showVoucher(BuildContext context, String voucher) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return VoucherForm(
          voucher: voucher,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    return DefaultBtn(
      text: 'Criar Voucher',
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        await createVoucher(context);
        setState(() {
          isLoading = false;
        });
      },
      height: 150.0,
    );
  }
}
// () async {
//   await _loadProfiles();
//   if (!mounted) return;
//   await showVoucher(context);
// }
