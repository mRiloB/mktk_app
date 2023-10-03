import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  final Widget child;
  const RoundedCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: child,
    );
  }
}
