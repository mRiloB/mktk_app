import 'package:flutter/material.dart';

class ReportInput extends StatelessWidget {
  final String title;
  const ReportInput({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(title),
          ),
          TextFormField(
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.date_range),
            ),
          ),
        ],
      ),
    );
  }
}
