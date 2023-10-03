import 'package:flutter/material.dart';
import 'package:mktk_app/src/ui/home/widgets/home.card.dart';

class HomeOthers extends StatelessWidget {
  const HomeOthers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Outras Configurações",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: const [
                HomeCard(
                  title: "Venda",
                  icon: Icons.wifi,
                  route: '/home',
                ),
                HomeCard(
                  title: "Histórico",
                  icon: Icons.history,
                  route: '/home',
                ),
                HomeCard(
                  title: "Relatório",
                  icon: Icons.insert_chart_outlined_rounded,
                  route: '/home',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
