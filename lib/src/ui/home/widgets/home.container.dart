import 'package:flutter/material.dart';
import 'package:mktk_app/src/ui/home/widgets/home.title.dart';

class HomeContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const HomeContainer({
    super.key,
    required this.title,
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: HomeTitle(title: title),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
