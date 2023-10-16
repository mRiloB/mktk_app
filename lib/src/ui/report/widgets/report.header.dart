import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';

class ReportHeader extends StatelessWidget {
  final Report report;
  const ReportHeader({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(report.boatName!),
            const Divider(),
            Text(report.partner!.name),
            Text(report.partner!.cnpj),
            const Divider(),
            Text(report.seller!.name),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
