// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/custom_input.dart';
import 'package:mktk_app/src/configuration/widgets/voucher_list_item.dart';
// import 'package:mktk_app/src/configuration/widgets/search_btn.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/services/voucher.service.dart';
// import 'package:mktk_app/src/shared/storage/configuration/vouchers.storage.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  TextEditingController inputFilter = TextEditingController();
  bool isLoading = false;
  VoucherService voucherService = VoucherService();
  List<Voucher> vouchers = [];
  List<Voucher> vouchersFiltered = [];
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadVouchers();
    });
  }

  @override
  void dispose() {
    inputFilter.dispose();
    super.dispose();
  }

  Future<void> _loadVouchers() async {
    setState(() {
      isLoading = true;
    });
    try {
      dynamic aux = await voucherService.getAll();
      setState(() {
        vouchers = aux;
        vouchersFiltered = vouchers;
        total = voucherService.calcTotal(vouchers);
      });
      debugPrint('VOUCHERS: ${vouchers.length}');
    } catch (e) {
      debugPrint('=== LOAD VOUCHERS ERROR: ${e.toString()}');
      _messageBox(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onFilterChange() {
    String editedText = inputFilter.text.toUpperCase().trim();
    setState(() {
      vouchersFiltered = voucherService.filterByName(vouchers, editedText);
      total = voucherService.calcTotal(vouchersFiltered);
    });
    debugPrint('Filtered: ${vouchersFiltered.length}');
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Profiles',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomInput(
                    control: inputFilter,
                    label: 'Filtro',
                    placeholder: 'Pesquise por um voucher...',
                    margin: 5.0,
                    onChanged: onFilterChange,
                  ),
                  const Text('actions'),
                  const Divider(),
                  VoucherList(
                    vouchers: vouchersFiltered,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('TOTAL:'),
                      Text('R\$ $total'),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
