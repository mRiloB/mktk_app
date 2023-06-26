import 'package:flutter/material.dart';

class DefaultBtn extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double? height;

  const DefaultBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        color: const Color(0xFF4758A9),
        textColor: Colors.white,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
