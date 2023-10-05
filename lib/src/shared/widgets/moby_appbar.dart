import 'package:flutter/material.dart';

class MobyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MobyAppBar({
    super.key,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(84, 163, 212, 1),
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
