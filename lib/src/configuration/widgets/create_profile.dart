import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/custom_input.dart';
import 'package:mktk_app/src/shared/services/api.service.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController rateLimit = TextEditingController();
  MkTkAPI api = MkTkAPI('ip/hotspot/user/profile');
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    rateLimit.dispose();
  }

  void _createProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, dynamic> payload = {
        "name": name.text.trim(),
        "rate-limit": rateLimit.text.trim(),
        "shared-users": "1"
      };
      dynamic result = await api.cmdAdd(payload);
      debugPrint('RESULT: $result');
    } catch (e) {
      debugPrint('=== CREATE PROFILE ERROR: ${e.toString()}');
      _messageBox(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInput(
              control: name,
              label: 'Nome do profile',
              placeholder: 'passageiros',
            ),
            CustomInput(
              label: "Rate Limit",
              control: rateLimit,
              placeholder: '1M/5M',
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createProfile,
                child: const Text('Salvar'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
