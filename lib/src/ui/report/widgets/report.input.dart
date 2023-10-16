import 'package:flutter/material.dart';

class ReportInput extends StatelessWidget {
  final String title;
  final Future<void> Function(dynamic a)? onTap;
  final TextEditingController? dateTextController = TextEditingController();
  ReportInput({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
            controller: dateTextController,
            onTap: () async {},
          ),
        ],
      ),
    );
  }
}
