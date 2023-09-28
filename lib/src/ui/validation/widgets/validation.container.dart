import 'package:flutter/material.dart';

class ValidationContainer extends StatelessWidget {
  final Widget child;
  const ValidationContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      child: Card(
        elevation: 20.0,
        margin: const EdgeInsets.only(
          top: 100.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }
}
