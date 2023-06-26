import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.control,
      required this.label,
      this.placeholder,
      this.noValid = false,
      this.margin = 20.0,
      this.onChanged});
  final TextEditingController control;
  final String label;
  final String? placeholder;
  final bool noValid;
  final double margin;
  final void Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: margin),
      child: TextFormField(
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
          labelText: label,
        ),
        onChanged: (value) => onChanged?.call(),
      ),
    );
  }
}
