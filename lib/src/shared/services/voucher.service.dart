import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/storage/configuration/vouchers.storage.dart';

class VoucherService {
  VoucherService();

  Future<List<Voucher>> getAll() async {
    List<Map<String, dynamic>> result = await VoucherStorage.getInfo();

    return result
        .map((e) => Voucher(
              id: e['id'],
              name: e['name'],
              server: e['server'],
              profile: e['profile'],
              limitUptime: e['limitUptime'],
              price: e['price'],
              createdAt: fmtDate(e['createdAt']),
              updatedAt: fmtDate(e['updatedAt']),
            ))
        .toList();
  }

  List<Voucher> filterByName(List<Voucher> vouchers, String name) {
    return vouchers
        .where(
          (e) => e.name.contains(name),
        )
        .toList();
  }

  // DATETIME
  String fmtDate(String date) {
    if (date.isEmpty) return '';
    return DateTime.parse(date).toIso8601String();
  }

  // TOTAL
  double calcTotal(List<Voucher> vouchers) {
    return vouchers.fold(
      0,
      (previousValue, element) => previousValue + element.price,
    );
  }
}
