import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/custom_input.dart';
import 'package:mktk_app/src/shared/models/connection.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/connection.storage.dart';
import 'package:mktk_app/src/shared/widgets/default_btn.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';

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
    mktkIp.dispose();
    mktkLogin.dispose();
    mktkPass.dispose();
    super.dispose();
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

  void _saveConnection() async {
    if (_formKey.currentState!.validate()) {
      setLoading(true);
      try {
        Connection formConn = Connection(
          mktkIp.text.trim(),
          mktkLogin.text.trim(),
          mktkPass.text.trim(),
        );
        if (isEditing) {
          await ConnectionStorage.edit(formConn);
          isEditing = false;
        } else {
          await ConnectionStorage.create(formConn);
        }
        _messageBox("As configurações foram salvas!");
        _clearForm();
      } catch (e) {
        debugPrint('=== CONNECTION PAGE SAVE ERROR: ${e.toString()}');
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
          'Conexão',
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
          padding: const EdgeInsets.all(10.0),
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
                isLoading
                    ? const Loader()
                    : DefaultBtn(
                        onPressed: _saveConnection,
                        text: 'Salvar',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
