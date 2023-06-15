import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/connection.page.dart';
import 'package:mktk_app/src/configuration/info.page.dart';
import 'package:mktk_app/src/configuration/profiles.page.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Embarcação',
              ),
              Tab(
                text: 'Conexão',
              ),
              Tab(
                text: 'Profiles',
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              InfoPage(),
              ConnectionPage(),
              ProfilesPage(),
            ],
          ),
        ),
      ),
    );
  }
}
