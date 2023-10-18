import 'package:flutter/widgets.dart';
import 'package:mktk_app/src/shared/widgets/moby_container.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MobyContainer(
      isLoading: isLoading,
      children: [],
    );
  }
}
