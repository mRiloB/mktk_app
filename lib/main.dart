import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/configuration.page.dart';
import 'package:mktk_app/src/configuration/connection.page.dart';
import 'package:mktk_app/src/configuration/info.page.dart';
import 'package:mktk_app/src/configuration/profiles.page.dart';
import 'package:mktk_app/src/home/home.page.dart';
import 'package:mktk_app/src/shared/themes/color_schemes.g.dart';
import 'src/shared/services/api.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
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
      routes: {
        '/': (context) => const HomePage(),
        '/config': (context) => const ConfigurationPage(),
        '/config/info': (context) => const InfoPage(),
        '/config/connection': (context) => const ConnectionPage(),
        '/config/profiles': (context) => const ProfilesPage(),
      },
      initialRoute: '/',
    );
  }
}
