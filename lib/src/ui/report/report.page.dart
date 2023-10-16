import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/report.controller.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';
import 'package:mktk_app/src/shared/widgets/moby_container.dart';
import 'package:mktk_app/src/ui/report/widgets/report.form.dart';
import 'package:mktk_app/src/ui/report/widgets/report.header.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Report report = Report();
  bool isLoading = false;
  bool isFormLoading = false;
  DateTimeRange selectedDate = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 3)),
    end: DateTime.now(),
  );
  TextEditingController dateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateTextController.text =
        '${getRawDate(selectedDate.start)} - ${getRawDate(selectedDate.end)}';
  }

  Future<void> loadVouchers() async {
    setState(() {
      isFormLoading = true;
    });
    try {
      Report aux = await ReportController().generate();
      // calcular porcentagem
      setState(() {
        report = aux;
      });
    } catch (e) {
      debugPrint('=== report error: ${e.toString()}');
    } finally {
      setState(() {
        isFormLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2023, 9),
      lastDate: DateTime(2101),
      locale: const Locale('pt'),
    );
    if (picked != null && picked != selectedDate) {
      debugPrint('=== date picked: $picked');
      setState(() {
        selectedDate = picked;
      });
      dateTextController.text =
          '${getRawDate(selectedDate.start)} - ${getRawDate(selectedDate.end)}';
    }
  }

  String getRawDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(84, 163, 212, 1);

    return MobyContainer(
      isLoading: isLoading,
      children: [
        ReportForm(
          children: [
            TextFormField(
              readOnly: true,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.date_range),
              ),
              controller: dateTextController,
              onTap: () async => await _selectDate(context),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: Loader(
                isLoading: isFormLoading,
                loaderChild: ElevatedButton(
                  onPressed: () async {
                    if (selectedDate.duration.isNegative) return;
                    await loadVouchers();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(primary),
                  ),
                  child: const Text('Filtrar'),
                ),
              ),
            ),
          ],
        ),
        report.boatName != null
            ? ReportHeader(report: report)
            : const SizedBox(),
      ],
    );
  }
}
