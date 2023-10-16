import 'package:flutter/material.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';

class ReportForm extends StatefulWidget {
  final List<Widget> children;
  const ReportForm({super.key, required this.children});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      title: 'Escolha o intervalo',
      children: [
        Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ...widget.children,
            ],
          ),
        )
      ],
    );
  }
}
