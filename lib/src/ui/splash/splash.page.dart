import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';

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
    Boat? boat = await BoatController().getBoat();
    Timer(const Duration(milliseconds: 3 * 1000), () {
      Navigator.of(context).pushReplacementNamed(
        boat == null ? '/validation' : '/home',
      );
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
