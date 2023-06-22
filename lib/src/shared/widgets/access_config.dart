import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/widgets/default_btn.dart';

class AccessConfig extends StatefulWidget {
  final String password;
  final String route;
  final String label;
  final void Function()? altNavigator;

  const AccessConfig({
    super.key,
    required this.password,
    required this.route,
    required this.label,
    this.altNavigator,
  });

  @override
  State<AccessConfig> createState() => _AccessConfigState();
}

class _AccessConfigState extends State<AccessConfig> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    password.dispose();
  }

  void _onEntrar() {
    if (_formKey.currentState!.validate()) {
      if (password.text.trim() == widget.password) {
        Navigator.pop(context);
        if (widget.altNavigator != null) {
          widget.altNavigator?.call();
        } else {
          Navigator.pushNamed(context, widget.route);
        }
      } else {
        _messageBox('Senha incorreta. Tente novamente!');
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: password,
              keyboardType: TextInputType.number,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: '*****',
                labelText: widget.label,
              ),
            ),
            Container(
              height: 10.0,
            ),
            DefaultBtn(
              text: 'Entrar',
              onPressed: _onEntrar,
            ),
          ],
        ),
      ),
    );
  }
}
