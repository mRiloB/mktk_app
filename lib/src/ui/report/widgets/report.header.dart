import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';
import 'package:mktk_app/src/ui/report/widgets/header.cell.dart';

class ReportHeader extends StatelessWidget {
  final Report report;
  const ReportHeader({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(84, 163, 212, 1);
    String calcTotalPlan() {
      return report.plans!.entries
          .fold<double>(0, (prev, plan) => prev + plan.value['total'])
          .toString();
    }

    String calcQtdPlan() {
      return report.plans!.entries
          .fold<double>(0, (prev, plan) => prev + plan.value['qtd'])
          .toInt()
          .toString();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              report.boatName!,
              style: TextStyle(
                  color: primary, fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text(
              report.partner!.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(report.partner!.cnpj),
            const Divider(),
            Text('Caixa: ${report.seller!.name}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Referência: ${report.reference}'),
            const Divider(),
            const Text('Total por tipo de pagamento:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  children: [
                    HeaderCell(text: 'Dinheiro'),
                    HeaderCell(text: 'Débito'),
                    HeaderCell(text: 'Crédito'),
                    HeaderCell(text: 'PIX'),
                    HeaderCell(text: 'Total'),
                  ],
                ),
                TableRow(
                  children: [
                    HeaderCell(
                        text: report.dinheiro['total'], align: TextAlign.right),
                    HeaderCell(
                        text: report.debito['total'], align: TextAlign.right),
                    HeaderCell(
                        text: report.credito['total'], align: TextAlign.right),
                    HeaderCell(
                        text: report.pix['total'], align: TextAlign.right),
                    HeaderCell(text: report.total, align: TextAlign.right),
                  ],
                ),
              ],
            ),
            const Divider(),
            const Text('Total por plano de acesso:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  children: [
                    HeaderCell(text: 'Plano'),
                    HeaderCell(text: 'Qtd'),
                    HeaderCell(text: 'Total'),
                  ],
                ),
                ...report.plans!.entries
                    .map(
                      (plan) => TableRow(
                        children: [
                          HeaderCell(text: plan.key, align: TextAlign.left),
                          HeaderCell(text: plan.value['qtd']),
                          HeaderCell(
                              text: plan.value['total'],
                              align: TextAlign.right),
                        ],
                      ),
                    )
                    .toList(),
                TableRow(
                  children: [
                    const HeaderCell(text: 'Total', align: TextAlign.left),
                    HeaderCell(text: calcQtdPlan()),
                    HeaderCell(text: calcTotalPlan(), align: TextAlign.right),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
