import 'package:mktk_app/src/shared/models/partner.model.dart';
import 'package:mktk_app/src/shared/models/seller.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';

class Report {
  final String? boatName;
  final Partner? partner;
  final Seller? seller;
  List<Voucher> vouchers;
  Map<String, dynamic> dinheiro;
  Map<String, dynamic> credito;
  Map<String, dynamic> debito;
  Map<String, dynamic> pix;
  double total;
  String reference;
  Map<String, dynamic>? plans;

  Report({
    this.boatName,
    this.partner,
    this.seller,
    this.vouchers = const [],
    this.dinheiro = const {},
    this.credito = const {},
    this.debito = const {},
    this.pix = const {},
    this.total = 0.0,
    this.reference = '',
    this.plans,
  });
}
