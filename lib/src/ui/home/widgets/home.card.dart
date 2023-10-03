import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/widgets/rounded_card.dart';

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const HomeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(70, 129, 233, 1);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: RoundedCard(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50.0,
                color: primary,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
