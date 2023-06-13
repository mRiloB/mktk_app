import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/custom_input.dart';
import 'package:localstorage/localstorage.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mktkIp = TextEditingController();
  TextEditingController mktkUser = TextEditingController();
  TextEditingController mktkPass = TextEditingController();
  TextEditingController mktkLimitUptime = TextEditingController();
  final LocalStorage storage = LocalStorage('configuration.json');
  final LocalStorage storageVoucher = LocalStorage('voucher_user.json');

  @override
  void initState() {
    super.initState();
    try {
      bool isConfigLS = storage.getItem('isConfig');
      Map<String, String> configLS = storage.getItem('config');

      if (isConfigLS) {
        mktkIp.text = configLS["ip"]!;
        mktkUser.text = configLS["user"]!;
        mktkPass.text = configLS["password"]!;
        mktkLimitUptime.text = configLS["limit-uptime"]!;
      }
    } catch (e) {
      storage.setItem('isConfig', false);
    }
  }

  @override
  void dispose() {
    mktkIp.dispose();
    mktkUser.dispose();
    mktkPass.dispose();
    mktkLimitUptime.dispose();
    super.dispose();
  }

  void _clearStorage() async {
    await storageVoucher.clear();
    _messageBox('Voucher storage limpo!');
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
                control: mktkIp,
                label: 'IP',
                placeholder: '127.0.0.1',
              ),
              CustomInput(
                label: "Usuário",
                control: mktkUser,
                placeholder: 'Usuário',
              ),
              CustomInput(
                label: "Senha",
                control: mktkPass,
                placeholder: 'Senha',
                noValid: true,
              ),
              CustomInput(
                label: "Viagem Completa [limit-uptime]",
                control: mktkLimitUptime,
                placeholder: '0d 00:00:00',
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await storage.setItem('config', {
                        'ip': mktkIp.text,
                        'user': mktkUser.text,
                        'password': mktkPass.text,
                        'limit-uptime': mktkLimitUptime.text,
                      });
                      await storage.setItem('isConfig', true);
                      _messageBox("As configurações foram salvas!");
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    _clearStorage();
                  },
                  child: const Text('Limpar LocalStorage'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
