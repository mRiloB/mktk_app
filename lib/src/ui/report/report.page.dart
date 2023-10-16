import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/report.controller.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';
import 'package:mktk_app/src/shared/widgets/moby_container.dart';
import 'package:mktk_app/src/ui/report/widgets/report.form.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Report report = Report();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadVouchers();
  }

  void loadVouchers() async {
    setState(() {
      isLoading = true;
    });
    try {
      Report aux = await ReportController().generate();
      setState(() {
        report = aux;
      });
    } catch (e) {
      debugPrint('=== report error: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobyContainer(
      isLoading: isLoading,
      children: const [ReportForm()],
    );
  }
}
