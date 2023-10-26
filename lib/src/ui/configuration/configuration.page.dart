import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/master.controller.dart';
import 'package:mktk_app/src/shared/widgets/list_card.dart';
import 'package:mktk_app/src/shared/widgets/mscaffold.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MScaffold(
      isLoading: isLoading,
      children: [
        HomeContainer(
          title: 'Rápidas',
          children: [
            ListCard(
              icon: Icons.print,
              title: 'Impressão',
              onTap: () async {
                Navigator.of(context).pushNamed('/printer');
              },
            ),
            ListCard(
              icon: Icons.cleaning_services_rounded,
              title: 'Limpar senhas',
              onTap: () {},
            ),
          ],
        ),
        HomeContainer(
          title: 'Restritas',
          children: [
            ListCard(
              icon: Icons.remove_circle_sharp,
              title: 'Restaurar',
              onTap: () async {
                await MasterController.clear();
                if (!mounted) return;
                await Navigator.of(context).pushReplacementNamed('/splash');
              },
            ),
          ],
        ),
      ],
    );
  }
}
