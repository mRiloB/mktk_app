import 'package:flutter/material.dart';

class VoucherBtn extends StatelessWidget {
  final dynamic Function() onPressed;
  final String title;

  const VoucherBtn({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
