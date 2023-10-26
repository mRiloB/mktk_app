import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/controllers/plan.controller.dart';
import 'package:mktk_app/src/shared/controllers/printer.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/shared/widgets/error_dialog.dart';
import 'package:mktk_app/src/shared/widgets/mscaffold.dart';
import 'package:mktk_app/src/ui/home/widgets/home.others.dart';
import 'package:mktk_app/src/ui/home/widgets/home.plans.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Boat boat = Boat(abbr: "", name: "");
  List<Plan> plans = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    debugPrint("=== init");
    loadBoatInfo();
    connectPrinter();
  }

  @override
  void dispose() async {
    await PrinterController.disconnectLocalDevice();
    super.dispose();
  }

  void loadBoatInfo() async {
    setState(() {
      isLoading = true;
    });
    try {
      Boat? localBoat = await BoatController().getBoat();
      List<Plan> localPlans = await PlanController().getPlans();
      setState(() {
        boat = localBoat!;
        plans.addAll(localPlans);
      });
    } catch (e) {
      debugPrint('=== home error: $e');
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (BuildContext context) => ErrorDialog(
          message: e.toString(),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void connectPrinter() async {
    bool hasLocalPrinter = await PrinterController.connectLocalDevice();
    if (hasLocalPrinter) {
      final snackBar = SnackBar(
        content: const Text('Dispositivo conectado!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      isLoading: isLoading,
      children: [
        HomePlans(plans: plans),
        const HomeOthers(),
      ],
    );
  }
}
