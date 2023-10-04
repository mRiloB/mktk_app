import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/controllers/supabase/boatsb.controller.dart';
import 'package:mktk_app/src/shared/controllers/supabase/sellersb.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/models/seller.model.dart';
import 'package:mktk_app/src/shared/widgets/gen_card.dart';
import 'package:mktk_app/src/shared/widgets/loader.dart';
import 'package:mktk_app/src/ui/validation/widgets/validation.appbar.dart';
import 'package:mktk_app/src/ui/validation/widgets/validation.content.dart';

class ValidationPage extends StatefulWidget {
  const ValidationPage({super.key});

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  bool isLoading = false;
  List<Boat> boats = [Boat(abbr: "", name: "Nenhuma embarcação")];
  String boatSelected = "";

  @override
  void initState() {
    super.initState();
    getBoats();
  }

  Future<void> getBoats() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Boat> sbBoats = await BoatSBController().getBoats();
      setState(() {
        boats.addAll(sbBoats);
      });
    } catch (e) {
      debugPrint('=== validation error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onConfirm() async {
    if (boatSelected.isEmpty) return;
    setState(() {
      isLoading = true;
    });
    try {
      Boat boat = boats.firstWhere(
        (element) => element.abbr == boatSelected,
      );
      // await BoatController().save(boat);
      Seller seller = await SellerSBController().getSellerById(boat.sellerId!);
      debugPrint("=== $boatSelected SELLER: ${seller.name}");
      if (!mounted) return;
      // Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      debugPrint('=== validation onConfirm error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ValidationAppBar(
        height: 100.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GenCard(
          child: Loader(
            isLoading: isLoading,
            loaderChild: ValidationContent(
              boats: boats,
              boatSelected: boatSelected,
              onBoatChanged: (Boat? boat) {
                setState(() {
                  boatSelected = boat!.abbr;
                });
              },
              onConfirm: onConfirm,
            ),
          ),
        ),
      ),
    );
  }
}
