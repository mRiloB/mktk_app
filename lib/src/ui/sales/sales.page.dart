import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/voucher.controller.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/services/api.service.dart';
import 'package:mktk_app/src/shared/widgets/moby_container.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';
import 'package:mktk_app/src/ui/sales/widgets/sales.card.dart';
import 'package:mktk_app/src/ui/sales/widgets/sales.voucher.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  Plan plan = Plan(name: '', price: 0);
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
      Map<String, dynamic> data = {
        "name": newVoucher,
        "profile": plan.name,
        "server": "all",
        "comment": "ADICIONADO VIA APP MOBY VOUCHERS"
      };
      await MkTkAPI.cmdAdd('/ip/hotspot/user', data);
      await VoucherController().save(
        Voucher(
          name: newVoucher,
          server: 'all',
          profile: plan.name,
          limitUptime: '',
          payment: payment,
          price: plan.price,
        ),
      );
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('=== create access error: ${e.toString()}');
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
        SalesVoucher(voucher: newVoucher, plan: plan),
        HomeContainer(
          title: 'Pagamentos',
          children: [
            SizedBox(
              height: 95.0,
              child: GridView.count(
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
            )
          ],
        )
      ],
    );
  }
}
