import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/voucher.controller.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/widgets/error_dialog.dart';
import 'package:mktk_app/src/shared/widgets/mscaffold.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';
import 'package:mktk_app/src/ui/sales/widgets/sales.card.dart';
import 'package:mktk_app/src/ui/sales/widgets/sales.voucher.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  Plan plan = Plan(name: '', price: 0, limitUptime: '');
  String newVoucher = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setNewVoucher();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Plan args = ModalRoute.of(context)!.settings.arguments as Plan;
    setState(() {
      plan = args;
    });
  }

  void setNewVoucher() async {
    setState(() {
      isLoading = true;
    });
    String aux = await VoucherController().create();
    setState(() {
      newVoucher = aux;
      isLoading = false;
    });
  }

  void createAccess(String payment) async {
    setState(() {
      isLoading = true;
    });
    try {
      Voucher voucher = Voucher(
        name: newVoucher,
        server: 'all',
        profile: plan.name,
        limitUptime: plan.limitUptime,
        payment: payment,
        price: plan.price,
      );
      await VoucherController().save(voucher, plan);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('=== create access error: ${e.toString()}');
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

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      isLoading: isLoading,
      children: [
        SalesVoucher(voucher: newVoucher, plan: plan),
        HomeContainer(
          title: 'Pagamentos',
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              children: [
                SalesCard(
                  onTap: () => createAccess('dinheiro'),
                  icon: Icons.price_change_outlined,
                  title: 'Dinheiro',
                ),
                SalesCard(
                  onTap: () => createAccess('debito'),
                  icon: Icons.credit_card,
                  title: 'Débito',
                ),
                SalesCard(
                  onTap: () => createAccess('credito'),
                  icon: Icons.credit_card,
                  title: 'Crédito',
                ),
                SalesCard(
                  onTap: () => createAccess('pix'),
                  icon: Icons.pix,
                  title: 'PIX',
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
