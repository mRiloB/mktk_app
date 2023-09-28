import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    debugPrint("=== init");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
          elevation: 0,
          title: const Text("Moby Vouchers"),
        ),
        body: const Center(
          child: Text("Moby Vouchers"),
        ),
      ),
    );
  }
}
