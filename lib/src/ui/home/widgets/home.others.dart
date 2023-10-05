import 'package:flutter/material.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';
import 'package:mktk_app/src/ui/home/widgets/others.card.dart';

class HomeOthers extends StatelessWidget {
  const HomeOthers({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      title: 'Outros',
      children: [
        SizedBox(
          height: 125.0,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: const [
              OthersCard(icon: Icons.history, title: 'Histórico'),
              OthersCard(icon: Icons.bar_chart_rounded, title: 'Relatório'),
              OthersCard(icon: Icons.settings, title: 'Configurações'),
            ],
          ),
        )
      ],
    );
  }
}
