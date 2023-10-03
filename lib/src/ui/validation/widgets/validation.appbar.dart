import 'package:flutter/material.dart';

class ValidationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const ValidationAppBar({
    super.key,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Add AppBar here only
      backgroundColor: const Color.fromRGBO(70, 129, 233, 1),
      elevation: 0.0,
      title: Image.asset(
        'assets/img/logo-moby.png',
        height: 100.0,
      ),
      centerTitle: true,
      toolbarHeight: height,
    );
  }
}
