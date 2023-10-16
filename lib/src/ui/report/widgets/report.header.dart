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
            Text(
                'Dinheiro (${report.dinheiro['qtd']}): ${report.dinheiro['total']}'),
            Text('Débito (${report.debito['qtd']}): ${report.debito['total']}'),
            Text(
                'Crédito (${report.credito['qtd']}): ${report.credito['total']}'),
            Text('Pix (${report.pix['qtd']}): ${report.pix['total']}'),
            const Divider(),
            Text('TOTAL (${report.vouchers!.length}): ${report.total}'),
          ],
        ),
      ),
    );
  }
}
