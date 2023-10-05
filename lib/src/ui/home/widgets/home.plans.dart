import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/ui/home/widgets/home.card.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';

class HomePlans extends StatelessWidget {
  final List<Plan> plans;
  const HomePlans({
    super.key,
    required this.plans,
  });

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      title: 'Planos',
      children: [
        SizedBox(
          height: 200.0,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ...plans.map(
                (plan) => HomeCard(title: plan.name),
              )
            ],
          ),
        ),
      ],
    );
  }
}
