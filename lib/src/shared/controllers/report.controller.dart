import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/controllers/supabase/boatsb.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';

class ReportController {
  Future<void> generate() async {
    Boat? boat = await BoatController().getBoat();
    Report report = await BoatSBController().getBoatsAndForeign(boat!.abbr);
    debugPrint(report.toString());
  }
}
