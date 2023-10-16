import 'package:mktk_app/src/shared/models/partner.model.dart';
import 'package:mktk_app/src/shared/models/seller.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';

class Report {
  final String? boatName;
  final Partner? partner;
  final Seller? seller;
  List<Voucher>? vouchers;

  Report({
    this.boatName,
    this.partner,
    this.seller,
    this.vouchers = const [],
  });
}
