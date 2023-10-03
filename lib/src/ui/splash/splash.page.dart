import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mktk_app/src/controllers/boat.controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    mockSplash();
  }

  void mockSplash() async {
    debugPrint('=== indo pra home depois de 3s');
    String route =
        await BoatController().existsLocal() ? '/home' : '/validation';
    Timer(const Duration(milliseconds: 3 * 1000), () {
      Navigator.of(context).pushReplacementNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(70, 129, 233, 1),
        ),
        child: Center(
          child: Image.asset(
            'assets/img/logo-splash.png',
            height: 200,
          ),
        ),
      ),
    );
  }
}
