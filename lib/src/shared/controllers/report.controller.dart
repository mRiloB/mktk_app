import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/controllers/supabase/boatsb.controller.dart';
import 'package:mktk_app/src/shared/controllers/voucher.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';

class ReportController {
  Future<Report> generate() async {
    Boat? boat = await BoatController().getBoat();
    List<Voucher> vouchers = await VoucherController().getVouchers();
    Report report = await BoatSBController().getBoatsAndForeign(boat!.abbr);
    report.vouchers = vouchers;
    return report;
  }
}
