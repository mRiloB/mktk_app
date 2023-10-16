import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/ui/home/widgets/home.card.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';

class SalesVoucher extends StatelessWidget {
  final String voucher;
  final Plan plan;

  const SalesVoucher({
    super.key,
    required this.voucher,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      title: 'Voucher',
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeCard(
              title: voucher,
              icon: Icons.person,
              onTap: () {},
            ),
            HomeCard(
              title: plan.name,
              icon: Icons.wifi_tethering,
              onTap: () {},
            ),
            HomeCard(
              title: plan.price.toString(),
              icon: Icons.attach_money,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
