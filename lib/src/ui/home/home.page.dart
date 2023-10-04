import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';
import 'package:mktk_app/src/ui/home/widgets/home.appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Boat boat = Boat(abbr: "", name: "");
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
      setState(() {
        boat = localBoat!;
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
      child: Scaffold(
        appBar: HomeAppBar(
          title: boat.name,
          height: 80.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Loader(
            isLoading: isLoading,
            loaderChild: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // HomePlans(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
