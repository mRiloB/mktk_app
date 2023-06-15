import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/custom_input.dart';
import 'package:mktk_app/src/shared/models/info.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/configuration.hive.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController boatName = TextEditingController();
  TextEditingController seller = TextEditingController();
  ConfigurationCollection configCollection = ConfigurationCollection();

  @override
  void initState() {
    super.initState();
    try {
      Info hiveInfo = configCollection.getInfo() ?? Info();
      if (!hiveInfo.isEmpty) {
        boatName.text = hiveInfo.boatName;
        seller.text = hiveInfo.seller;
      }
    } catch (e) {
      debugPrint('=== INFO PAGE INIT: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    boatName.dispose();
    seller.dispose();
    super.dispose();
  }

  void _saveInfo() {
    if (_formKey.currentState!.validate()) {
      try {
        configCollection.saveInfo(
          Info(
            boatName.text.trim(),
            seller.text.trim(),
          ),
        );
        _messageBox("As informações foram salvas!");
        _clearForm();
      } catch (e) {
        debugPrint('=== INFO PAGE SAVE ERROR: ${e.toString()}');
        _messageBox(e.toString());
      }
    }
  }

  void _messageBox(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () {},
        ),
      ),
    );
  }

  void _clearForm() {
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInput(
                control: boatName,
                label: 'Nome da Embarcação',
                placeholder: '...',
              ),
              CustomInput(
                label: "Nome do Vendedor",
                control: seller,
                placeholder: 'Fulano de tal',
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveInfo,
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
