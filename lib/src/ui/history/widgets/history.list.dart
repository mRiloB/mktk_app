import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';

class HistoryList extends StatelessWidget {
  final List<Voucher> vouchers;
  const HistoryList({super.key, required this.vouchers});

  @override
  Widget build(BuildContext context) {
    // Color primary = const Color.fromRGBO(84, 163, 212, 1);
    return ListView(
      shrinkWrap: true,
      reverse: true,
      children: const [],
    );
  }
}
