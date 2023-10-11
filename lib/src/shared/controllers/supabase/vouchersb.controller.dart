import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VoucherSBController {
  Future<void> save(Voucher voucher) async {
    Boat? boat = await BoatController().getBoat();
    Map<String, dynamic> data = {
      'abbr': boat!.abbr,
      'voucher': voucher.name,
      'profile': voucher.profile,
      'limit_uptime': voucher.limitUptime,
      'payment': voucher.payment,
      'price': voucher.price,
    };
    dynamic a =
        await Supabase.instance.client.from('vouchers').insert(data).select();
    debugPrint('=== voucher sb: ${a.toString()}');
  }
}
