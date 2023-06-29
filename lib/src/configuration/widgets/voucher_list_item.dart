import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:intl/intl.dart';
import 'package:mktk_app/src/shared/services/voucher.service.dart';

class VoucherList extends StatefulWidget {
  final List<Voucher> vouchers;

  const VoucherList({
    super.key,
    required this.vouchers,
  });

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  VoucherService voucherService = VoucherService();

  String dateFmt(String date) {
    DateTime ldate = DateTime.parse(date);

    return DateFormat('dd/MM/yyyy H:m').format(ldate);
  }

  Future<void> onDelete(Voucher voucher) async {
    try {
      await voucherService.deleteVoucher(voucher);
      _messageBox('Voucher removido!');
    } catch (e) {
      debugPrint('=== DELETE VOUCHER ERROR: ${e.toString()}');
      _messageBox(e.toString());
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
    return Expanded(
      child: ListView(
        children: widget.vouchers
            .map(
              (Voucher vou) => Card(
                shape: BorderDirectional(
                  start: BorderSide(
                    width: 8.0,
                    color: vou.updatedAt.isNotEmpty ? Colors.red : Colors.green,
                  ),
                ),
                child: ListTile(
                  title: Text('${vou.name} - ${vou.payment}'),
                  subtitle: Text('${vou.profile} | ${dateFmt(vou.createdAt)}'),
                  trailing: vou.updatedAt.isNotEmpty
                      ? const Text('DEV')
                      : IconButton.filled(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red),
                          ),
                          color: Colors.white,
                          onPressed: () async => await onDelete(vou),
                          icon: const Icon(Icons.delete),
                        ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
