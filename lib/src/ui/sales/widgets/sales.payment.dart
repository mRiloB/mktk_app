import 'package:flutter/material.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';
import 'package:mktk_app/src/ui/sales/widgets/sales.card.dart';

class SalesPayment extends StatelessWidget {
  const SalesPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      title: 'Pagamentos',
      children: [
        SizedBox(
          height: 95.0,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            children: const [
              SalesCard(
                icon: Icons.price_change_outlined,
                title: 'Dinheiro',
              ),
              SalesCard(
                icon: Icons.credit_card,
                title: 'Débito',
              ),
              SalesCard(
                icon: Icons.credit_card,
                title: 'Crédito',
              ),
              SalesCard(
                icon: Icons.pix,
                title: 'PIX',
              ),
            ],
          ),
        )
      ],
    );
  }
}
