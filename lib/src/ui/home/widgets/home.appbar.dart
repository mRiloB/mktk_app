import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const HomeAppBar({
    super.key,
    required this.title,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(70, 129, 233, 1),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
      toolbarHeight: height,
    );
  }
}
