import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/custom_input.dart';
import 'package:mktk_app/src/shared/models/info.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/info.storage.dart';
import 'package:mktk_app/src/shared/widgets/default_btn.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';

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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  void dispose() {
    boat.dispose();
    seller.dispose();
    super.dispose();
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

  void _saveInfo() async {
    if (_formKey.currentState!.validate()) {
      setLoading(true);
      try {
        Info formInfo = Info(
          boat.text.trim(),
          seller.text.trim(),
        );
        if (isEditing) {
          await InfoStorage.edit(formInfo);
          isEditing = false;
        } else {
          await InfoStorage.create(formInfo);
        }
        _messageBox("As informações foram salvas!");
        _clearForm();
      } catch (e) {
        debugPrint('=== INFO PAGE SAVE ERROR: ${e.toString()}');
        _messageBox(e.toString());
      } finally {
        setLoading(false);
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

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void _clearForm() {
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Embarcação',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
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
              isLoading
                  ? const Loader()
                  : DefaultBtn(
                      text: 'Salvar',
                      onPressed: _saveInfo,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
