import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/info.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/configuration.hive.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    ConfigurationCollection configCollection = ConfigurationCollection();
    Info hiveInfo = configCollection.getInfo() ?? Info();

    return Column(
      children: [
        Text(hiveInfo.boatName),
      ],
    );
  }
}
