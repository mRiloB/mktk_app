import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:intl/intl.dart';

class VoucherList extends StatelessWidget {
  final List<Voucher> vouchers;

  const VoucherList({super.key, required this.vouchers});

  String dateFmt(String date) {
    DateTime ldate = DateTime.parse(date);

    return DateFormat('dd/MM/yyyy H:m:s').format(ldate);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: vouchers
            .map((Voucher vou) => Card(
                  shape: BorderDirectional(
                    start: BorderSide(
                      width: 10.0,
                      color:
                          vou.updatedAt.isNotEmpty ? Colors.red : Colors.green,
                    ),
                  ),
                  child: ListTile(
                    title: Text('${vou.name} - ${vou.profile}'),
                    subtitle: Text(dateFmt(vou.createdAt)),
                    trailing: Text('R\$ ${vou.price}'),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
