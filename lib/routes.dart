import 'package:flutter/widgets.dart';
import 'package:mktk_app/src/ui/printer/printer.page.dart';
import 'package:mktk_app/src/ui/splash/splash.page.dart';
import 'package:mktk_app/src/ui/validation/validation.page.dart';
import 'package:mktk_app/src/ui/home/home.page.dart';
import 'package:mktk_app/src/ui/active/active.page.dart';
import 'package:mktk_app/src/ui/sales/sales.page.dart';
import 'package:mktk_app/src/ui/history/history.page.dart';
import 'package:mktk_app/src/ui/report/report.page.dart';
import 'package:mktk_app/src/ui/configuration/configuration.page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashPage(),
    '/validation': (context) => const ValidationPage(),
    '/home': (context) => const HomePage(),
    '/active': (context) => const ActivePage(),
    '/sales': (context) => const SalesPage(),
    '/report': (context) => const ReportPage(),
    '/history': (context) => const HistoryPage(),
    '/configuration': (context) => const ConfigurationPage(),
    '/printer': (context) => const PrinterPage(),
  };
  static String initialRoute = '/';
}
