import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/info.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/configuration.hive.dart';
import 'package:lottie/lottie.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    ConfigurationCollection configCollection = ConfigurationCollection();
    Info hiveInfo = configCollection.getInfo() ?? Info();

    return Column(
      children: [
        Transform.translate(
          offset: const Offset(0, -30.0),
          child: Lottie.asset(
            'assets/animations/moby-boat.json',
            width: double.infinity,
            height: 250.0,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -80.0),
          child: Text(
            hiveInfo.boatName,
            style: const TextStyle(
                fontSize: 30.0,
                color: Color(0xFF4758A9),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.2,
                height: 1.4,
                overflow: TextOverflow.ellipsis,
                shadows: [
                  Shadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
