import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';
import 'package:mktk_app/src/shared/widgets/moby_appbar.dart';

class MobyContainer extends StatelessWidget {
  final List<Widget> children;
  final bool isLoading;
  final bool reverse;
  const MobyContainer({
    super.key,
    this.children = const <Widget>[],
    this.isLoading = false,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobyAppBar(
        height: 100.0,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/wave-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Loader(
          isLoading: isLoading,
          loaderChild: ListView(
            reverse: reverse,
            padding: const EdgeInsets.all(10.0),
            children: children,
          ),
        ),
      ),
    );
  }
}
