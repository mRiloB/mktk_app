import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/shared/services/voucher.service.dart';
import 'package:mktk_app/src/shared/widgets/gen_card.dart';
import 'package:mktk_app/src/shared/widgets/moby_container.dart';
import 'package:mktk_app/src/ui/sales/widgets/sales.payment.dart';
import 'package:mktk_app/src/ui/sales/widgets/sales.voucher.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  Plan plan = Plan(name: '', price: 0);
  String newVoucher = '';

  @override
  void initState() {
    super.initState();
    setNewVoucher();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Plan args = ModalRoute.of(context)!.settings.arguments as Plan;
    plan = args;
  }

  void setNewVoucher() {
    String aux = VoucherService.generateVoucher();
    setState(() {
      newVoucher = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MobyContainer(
      children: [
        SalesVoucher(voucher: newVoucher, plan: plan),
        const SalesPayment(),
      ],
    );
  }
}
