import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mktk_app/src/shared/controllers/supabase/vouchersb.controller.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/services/api.service.dart';
import 'package:mktk_app/src/shared/services/printer.service.dart';
import 'package:mktk_app/src/shared/services/voucher.service.dart';
import 'package:mktk_app/src/shared/storage/voucher.storage.dart';

class VoucherController {
  Future<List<Voucher>> getVouchers() async {
    List<Map<String, dynamic>> vouchers = await VoucherStorage.select();
    return vouchers
        .map(
          (voucher) => Voucher(
            id: voucher['id'],
            name: voucher['name'],
            server: voucher['server'],
            profile: voucher['profile'],
            limitUptime: voucher['limit_uptime'],
            payment: voucher['payment'],
            price: voucher['price'],
            createdAt: voucher['created_at'],
            updatedAt: voucher['updated_at'],
          ),
        )
        .toList();
  }

  Future<void> save(Voucher voucher, Plan plan) async {
    Map<String, dynamic> data = {
      "name": voucher.name,
      "profile": plan.name,
      "server": "all",
      "limit-uptime": plan.limitUptime,
      "comment": "VIA APP MOBY VOUCHERS",
    };
    voucher.createdAt =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString();
    await MkTkAPI.cmdAdd('/ip/hotspot/user', data);
    await VoucherStorage.insert(voucher);
    await VoucherSBController().save(voucher);
    await PrinterService.printVoucher(voucher);
  }

  Future<String> create() async {
    String voucher = VoucherService.generateVoucher();
    Map<String, dynamic> voucherExists =
        await VoucherStorage.selectByName(voucher);

    if (voucherExists.isNotEmpty) VoucherController().create();

    return voucher;
  }

  Future<void> extractDataFromLocal() async {
    List<Voucher> vouchers = await getVouchers();
    for (Voucher e in vouchers) {
      debugPrint('${e.name} | ${e.payment} | ${e.price} | ${e.createdAt}');
    }
  }
}
