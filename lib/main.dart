import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mktk_app/supabase.env.dart';
import 'package:mktk_app/src/shared/services/api.service.dart';
import 'package:mktk_app/src/ui/splash/splash.page.dart';
import 'package:mktk_app/src/ui/validation/validation.page.dart';
import 'package:mktk_app/src/ui/home/home.page.dart';
import 'package:mktk_app/src/ui/active/active.page.dart';
import 'package:mktk_app/src/ui/sales/sales.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Supabase.initialize(url: sbUrl, anonKey: sbAnonKey);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moby Vouchers',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/validation': (context) => const ValidationPage(),
        '/home': (context) => const HomePage(),
        '/active': (context) => const ActivePage(),
        '/sales': (context) => const SalesPage(),
      },
      initialRoute: '/',
    );
  }
}
