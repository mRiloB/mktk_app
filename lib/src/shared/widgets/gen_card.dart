import 'package:flutter/material.dart';

class GenCard extends StatelessWidget {
  final Widget child;

  const GenCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
