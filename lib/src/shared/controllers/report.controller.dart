import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/controllers/supabase/boatsb.controller.dart';
import 'package:mktk_app/src/shared/controllers/voucher.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';

class ReportController {
  Future<Report> generate(DateTime start, DateTime end) async {
    DateTime st = DateTime(start.year, start.month, start.day);
    DateTime en = DateTime(end.year, end.month, end.day);
    Boat? boat = await BoatController().getBoat();
    List<Voucher> vouchers = await VoucherController().getVouchers();
    Report report = await BoatSBController().getBoatsAndForeign(boat!.abbr);
    report.vouchers = vouchers.where((voucher) {
      List<int> createdAt = voucher.createdAt!
          .split(' ')[0]
          .split('-')
          .map((e) => int.parse(e))
          .toList();
      DateTime crea = DateTime(createdAt[0], createdAt[1], createdAt[2]);
      Duration day = const Duration(days: 1);
      return crea.isAfter(st.subtract(day)) && crea.isBefore(en.add(day));
    }).toList();
    return report;
  }

  Map<String, dynamic> totalByAttr(
    List<Voucher> vouchers,
    String attr, {
    String? payment,
    String? profile,
  }) {
    List<Voucher> vouchersByAttr = [];
    double total = 0.0;

    if (attr == 'payment') {
      vouchersByAttr =
          vouchers.where((voucher) => voucher.payment == payment).toList();
    } else if (attr == 'profile') {
      vouchersByAttr =
          vouchers.where((voucher) => voucher.profile == profile).toList();
    }
    total = vouchersByAttr.fold(0.0, (prev, voucher) => prev + voucher.price);

    return {
      'total': total,
      'qtd': vouchersByAttr.length,
    };
  }
}
