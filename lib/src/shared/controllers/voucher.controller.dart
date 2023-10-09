import 'package:intl/intl.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
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

  Future<void> save(Voucher voucher) async {
    voucher.createdAt =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString();
    await VoucherStorage.insert(voucher);
  }

  Future<String> create() async {
    String voucher = VoucherService.generateVoucher();
    Map<String, dynamic> voucherExists =
        await VoucherStorage.selectByName(voucher);

    if (voucherExists.isNotEmpty) VoucherController().create();

    return voucher;
  }
}
