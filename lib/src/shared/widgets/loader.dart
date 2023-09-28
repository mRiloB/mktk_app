import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool isLoading;
  final Widget loaderChild;
  const Loader({
    super.key,
    required this.isLoading,
    required this.loaderChild,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : loaderChild;
  }
}
