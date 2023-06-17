import 'package:flutter/material.dart';

class SearchBtn extends StatelessWidget {
  final void Function() onPressed;
  final String title;

  const SearchBtn({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: const Color(0xFF4758A9),
        child: SizedBox(
          width: double.infinity,
          height: 50.0,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                  height: 1.4,
                  overflow: TextOverflow.ellipsis,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 2.0,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
