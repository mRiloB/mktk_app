import 'package:flutter/material.dart';

class GridBtn extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;
  final String text;

  const GridBtn(
    this.icon,
    this.text,
    this.onPressed, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: const Color(0xFF4758A9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Container(
              height: 10.0,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
