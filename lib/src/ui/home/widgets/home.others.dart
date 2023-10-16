import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/master.controller.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';
import 'package:mktk_app/src/ui/home/widgets/others.card.dart';

class HomeOthers extends StatelessWidget {
  const HomeOthers({super.key});

  @override
  Widget build(BuildContext context) {
    void onConfigTap([bool mounted = true]) async {
      await MasterController.clear();
      if (!mounted) return;
      await Navigator.of(context).pushReplacementNamed('/');
    }

    void goto(String route) async {
      await Navigator.of(context).pushNamed(route);
    }

    return HomeContainer(
      title: 'Outros',
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          children: [
            const OthersCard(
              icon: Icons.history,
              title: 'Histórico',
            ),
            OthersCard(
              icon: Icons.bar_chart_rounded,
              title: 'Relatório',
              onTap: () => goto('/report'),
            ),
            OthersCard(
              icon: Icons.settings,
              title: 'Configurações',
              onTap: onConfigTap,
            ),
            OthersCard(
              icon: Icons.contactless_rounded,
              title: 'Ativos',
              onTap: () => goto('/active'),
            ),
          ],
        ),
      ],
    );
  }
}
