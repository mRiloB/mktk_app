import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ops... Houve um erro!'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 50.0,
              child: Icon(
                Icons.error,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const Text('Verifique sua conexão com a internet!'),
          const SizedBox(height: 10.0),
          const Text('Se o erro persistir comunique o suporte.'),
          const SizedBox(height: 10.0),
          const Divider(color: Colors.red, height: 5.0),
          const Text('O erro será especificado abaixo:'),
          const SizedBox(height: 10.0),
          Text(message),
          const Divider(color: Colors.red, height: 5.0),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}
