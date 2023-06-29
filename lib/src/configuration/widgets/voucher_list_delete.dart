import 'package:flutter/material.dart';

class VoucherListDelete extends StatelessWidget {
  final void Function()? onPressed;

  const VoucherListDelete({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.red),
      ),
      color: Colors.white,
      onPressed: onPressed,
      icon: const Icon(Icons.delete),
    );
  }
}
