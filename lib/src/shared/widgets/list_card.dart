import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ListCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(84, 163, 212, 1);
    return Card(
      color: primary,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        minLeadingWidth: 0,
      ),
    );
  }
}
