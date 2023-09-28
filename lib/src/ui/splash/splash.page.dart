import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // verificar se já foi configurado
    mockSplash();
  }

  void mockSplash() {
    Timer(const Duration(milliseconds: 3 * 1000), () {
      debugPrint('=== indo pra home depois de 3s');
      Navigator.of(context).pushReplacementNamed('/validation');
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
