import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  // final String route;

  const HomeCard({
    super.key,
    required this.title,
    // required this.route,
  });

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(84, 163, 212, 1);

    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(route);
      },
      child: Card(
        color: primary,
        child: ListTile(
          leading: const Icon(
            Icons.wifi,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          minLeadingWidth: 0,
        ),
      ),
    );
  }
}
