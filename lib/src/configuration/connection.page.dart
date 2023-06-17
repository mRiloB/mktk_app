import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/custom_input.dart';
import 'package:mktk_app/src/shared/models/connection.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/connection.storage.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mktkIp = TextEditingController();
  TextEditingController mktkLogin = TextEditingController();
  TextEditingController mktkPass = TextEditingController();
  Connection conn = Connection();
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
      List<Map<String, dynamic>> connStorage =
          await ConnectionStorage.getConnection();
      debugPrint('CONN: $connStorage');
      if (connStorage.isNotEmpty) {
        setState(() {
          mktkIp.text = connStorage[0]['ip'];
          mktkLogin.text = connStorage[0]['login'];
          mktkPass.text = connStorage[0]['password'];
          isEditing = true;
        });
      }
    } catch (e) {
      debugPrint('=== CONNECTION PAGE INIT: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    mktkIp.dispose();
    mktkLogin.dispose();
    mktkPass.dispose();
    super.dispose();
  }

  void _saveConnection() {
    if (_formKey.currentState!.validate()) {
      try {
        Connection formConn = Connection(
          mktkIp.text.trim(),
          mktkLogin.text.trim(),
          mktkPass.text.trim(),
        );
        if (isEditing) {
          ConnectionStorage.edit(formConn);
          isEditing = false;
        } else {
          ConnectionStorage.create(formConn);
        }
        _messageBox("As configurações foram salvas!");
        _clearForm();
      } catch (e) {
        debugPrint('=== CONNECTION PAGE SAVE ERROR: ${e.toString()}');
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInput(
                  control: mktkIp,
                  label: 'IP do Mikrotik',
                  placeholder: '192.168.0.0',
                ),
                CustomInput(
                  label: "Login",
                  control: mktkLogin,
                  placeholder: 'admin',
                ),
                CustomInput(
                  label: "Senha",
                  control: mktkPass,
                  placeholder: '********',
                  noValid: true,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveConnection,
                    child: const Text('Salvar'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      debugPrint('');
                    },
                    child: const Text('Resetar Configurações'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
