import 'package:flutter/material.dart';

class ValidationBackground extends StatelessWidget {
  const ValidationBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(70, 129, 233, 1),
      ),
      height: MediaQuery.of(context).size.height * 0.3,
    );
  }
}
