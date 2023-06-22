import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/widgets/access_config.dart';
import 'package:mktk_app/src/shared/storage/configuration/connection.storage.dart';
import 'package:mktk_app/src/vouchers/widgets/create_btn.dart';
import 'package:mktk_app/src/vouchers/widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class PageAux {
  Widget screen;
  String title;
  PageAux(this.screen, this.title);
}

class _HomePageState extends State<HomePage> {
  String version = 'v0.0.8';
  bool isConfig = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    debugPrint("=============== init");
    try {
      List<Map<String, dynamic>> connStorage =
          await ConnectionStorage.getConnection();
      debugPrint('CONN: $connStorage');
      if (connStorage.isNotEmpty) {
        setState(() {
          isConfig = true;
        });
      }
    } catch (e) {
      debugPrint('=== HOME PAGE INIT: ${e.toString()}');
    }
  }

  Future<void> accessConfig() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: AccessConfig(
            label: 'Senha do vendedor',
            route: '/config',
            password: '0000',
            altNavigator: () {},
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Moby Vouchers $version",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/config').then((value) {
                _init();
              });
            },
            icon: const Icon(Icons.settings),
            color: Colors.white,
          )
        ],
      ),
      body: isConfig
          ? const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Header(),
                CreateBtn(),
              ],
            )
          : const Center(
              child: Text("Faça a configuração do aplicativo."),
            ),
    );
  }
}
