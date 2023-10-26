import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/widgets/mcard.dart';
import 'package:mktk_app/src/shared/widgets/mtext.dart';

class MContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const MContainer({
    super.key,
    required this.title,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return MCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MText(title),
          const SizedBox(
            height: 10.0,
          ),
          ...children,
        ],
      ),
    );
  }
}
