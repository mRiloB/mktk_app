import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/voucher.controller.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/widgets/moby_container.dart';
import 'package:mktk_app/src/ui/history/widgets/history.list.dart';

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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobyContainer(
      isLoading: isLoading,
      children: [
        HistoryList(vouchers: vouchers),
      ],
    );
  }
}
