import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mktk_app/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mktk_app/supabase.env.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mktk_app/src/shared/services/api.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Supabase.initialize(url: sbUrl, anonKey: sbAnonKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moby Vouchers',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('pt'),
      ],
      routes: Routes.routes,
      initialRoute: Routes.initialRoute,
    );
  }
}
