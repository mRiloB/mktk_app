import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mktk_app/src/home/home.page.dart';
import 'package:mktk_app/src/shared/themes/color_schemes.g.dart';
import 'controllers/api.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  await Hive.openBox('configuration');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moby App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const HomePage(),
    );
  }
}
