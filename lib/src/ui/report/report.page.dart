import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/report.controller.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';
import 'package:mktk_app/src/shared/widgets/error_dialog.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';
import 'package:mktk_app/src/shared/widgets/mscaffold.dart';
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
    formatDateRange();
  }

  Future<void> loadVouchers() async {
    setState(() {
      isFormLoading = true;
    });
    try {
      Report aux = await ReportController()
          .generate(selectedDate.start, selectedDate.end);
      setState(() {
        report = aux;
      });
    } catch (e) {
      debugPrint('=== report error: ${e.toString()}');
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (BuildContext context) => ErrorDialog(
          message: e.toString(),
        ),
      );
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
    }
    formatDateRange();
  }

  void formatDateRange() {
    String result =
        '${ReportController.getRawDate(selectedDate.start)} - ${ReportController.getRawDate(selectedDate.end)}';
    dateTextController.text = result;
  }

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(84, 163, 212, 1);

    return MScaffold(
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
