import 'package:flutter/material.dart';

class MText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign align;
  const MText(
    this.text, {
    super.key,
    this.color = Colors.black,
    this.fontSize = 14.0,
    this.align = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
      textAlign: align,
    );
  }
}
