import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mktk_app/src/shared/storage/configuration/info.storage.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  // ConfigurationDatabase configDB = ConfigurationDatabase();
  String _boat = '...';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() async {
    try {
      List<Map<String, dynamic>> infoStorage = await InfoStorage.getInfo();
      debugPrint('INFO: $infoStorage');
      if (infoStorage.isNotEmpty) {
        _boat = infoStorage[0]['boat'];
      }
      setState(() {});
    } catch (e) {
      debugPrint('=== VOUCHERS PAGE INIT: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            _boat,
            style: const TextStyle(
                fontSize: 30.0,
                color: Color(0xFF4758A9),
                fontWeight: FontWeight.w500,
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
