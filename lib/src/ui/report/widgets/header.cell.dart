import 'package:flutter/material.dart';

class HeaderCell extends StatelessWidget {
  final dynamic text;
  final TextAlign align;

  const HeaderCell({
    super.key,
    required this.text,
    this.align = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.0,
      padding: const EdgeInsets.only(top: 3.0, left: 3.0, right: 3.0),
      child: Text(
        text.toString(),
        textAlign: align,
      ),
    );
  }
}
