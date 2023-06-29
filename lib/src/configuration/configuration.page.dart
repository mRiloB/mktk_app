import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/grid_btn.dart';
import 'package:mktk_app/src/shared/widgets/access_config.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final TextStyle textStyle = const TextStyle(color: Colors.white);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _navigate(String route) {
    Navigator.pushNamed(context, route);
  }

  Future<void> accessConfig(String route) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: AccessConfig(
            label: 'Senha Moby',
            route: '/config/$route',
            password: '1894',
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
        toolbarTextStyle: textStyle,
        title: Text(
          'Configurações',
          style: textStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: GridView.count(
        primary: true,
        padding: const EdgeInsets.all(10.0),
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          // GridBtn(
          //   Icons.directions_boat,
          //   'Embarcação',
          //   () => _navigate('/config/info'),
          // ),
          GridBtn(
            Icons.wifi,
            'Mikrotik',
            () => _navigate('/config/connection'),
          ),

          GridBtn(
            Icons.recent_actors,
            'Profiles',
            () => _navigate('/config/profiles'),
          ),

          GridBtn(
            Icons.bluetooth,
            'Bluetooth',
            () => _navigate('/config/bluetooth'),
          ),

          GridBtn(
            Icons.receipt_long_rounded,
            'Relatório',
            () => _navigate('/config/report'),
          ),
        ],
      ),
    );
  }
}
