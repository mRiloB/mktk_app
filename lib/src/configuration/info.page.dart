import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/custom_input.dart';
import 'package:mktk_app/src/shared/models/info.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/info.storage.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController boat = TextEditingController();
  TextEditingController seller = TextEditingController();
  Info info = Info();
  bool isEditing = false;

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
        setState(() {
          boat.text = infoStorage[0]['boat'];
          seller.text = infoStorage[0]['seller'];
          isEditing = true;
        });
      }
    } catch (e) {
      debugPrint('=== INFO PAGE INIT: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    boat.dispose();
    seller.dispose();
    super.dispose();
  }

  void _saveInfo() {
    if (_formKey.currentState!.validate()) {
      try {
        Info formInfo = Info(
          boat.text.trim(),
          seller.text.trim(),
        );
        if (isEditing) {
          InfoStorage.edit(formInfo);
          isEditing = false;
        } else {
          InfoStorage.create(formInfo);
        }
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
                control: boat,
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
