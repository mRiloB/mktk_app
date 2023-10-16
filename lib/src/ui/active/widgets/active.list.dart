import 'package:flutter/material.dart';
import 'package:mktk_app/src/ui/active/active.page.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';

class ActiveList extends StatelessWidget {
  final List<Active> actives;

  const ActiveList({
    super.key,
    required this.actives,
  });

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(84, 163, 212, 1);
    return HomeContainer(
      title: 'Usuários ativos: ${actives.length}',
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            ...actives.map(
              (active) => Card(
                child: ListTile(
                  leading: Icon(
                    Icons.wifi,
                    color: primary,
                  ),
                  title: Text(
                    active.user!,
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                  subtitle: Text(
                    '${active.address} | ${active.macaddress}',
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                  minLeadingWidth: 0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
