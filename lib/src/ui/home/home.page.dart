import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/controllers/plan.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';
import 'package:mktk_app/src/shared/widgets/moby_container.dart';
import 'package:mktk_app/src/ui/home/widgets/home.card.dart';
import 'package:mktk_app/src/ui/home/widgets/home.others.dart';
import 'package:mktk_app/src/ui/home/widgets/home.plans.dart';
import 'package:mktk_app/src/ui/home/widgets/home.title.dart';

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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MobyContainer(
        children: [
          HomePlans(plans: plans),
          const HomeOthers(),
        ],
      ),
    );
  }
}
