import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/voucher.controller.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/services/printer.service.dart';
import 'package:mktk_app/src/shared/widgets/error_dialog.dart';
import 'package:mktk_app/src/shared/widgets/list_card.dart';
import 'package:mktk_app/src/shared/widgets/mscaffold.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isLoading = false;
  List<Voucher> vouchers = [];

  @override
  void initState() {
    super.initState();
    loadVouchers();
  }

  void loadVouchers() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Voucher> aux = await VoucherController().getVouchers();
      setState(() {
        vouchers = aux;
      });
    } catch (e) {
      debugPrint('=== history error: ${e.toString()}');
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (BuildContext context) => ErrorDialog(
          message: e.toString(),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String dateFormatted(String date) {
    return date.split(' ')[0].split('-').reversed.join('/');
  }

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      isLoading: isLoading,
      children: [
        HomeContainer(title: 'Vouchers vendidos: ${vouchers.length}'),
        ...vouchers.map(
          (voucher) => ListCard(
            icon: Icons.wifi,
            title: voucher.name,
            subtitle:
                '${voucher.profile} | ${voucher.payment} | ${dateFormatted(voucher.createdAt!)}',
            onLongPress: () async =>
                await PrinterService.printVoucher(voucher, true),
          ),
        ),
      ],
    );
  }
}
