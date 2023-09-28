import 'package:flutter/material.dart';

class ValidationAppBar extends StatelessWidget {
  const ValidationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        // Add AppBar here only
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          "Moby Vouchers",
          style: TextStyle(
            fontSize: 26.0,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
