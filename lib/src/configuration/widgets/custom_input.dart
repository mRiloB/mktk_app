import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.control,
      required this.label,
      this.placeholder,
      this.noValid = false});
  final TextEditingController control;
  final String label;
  final String? placeholder;
  final bool noValid;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: control,
      validator: !noValid
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: placeholder,
          labelText: label),
    );
  }
}
