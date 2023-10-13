import 'package:mktk_app/src/shared/models/partner.model.dart';
import 'package:mktk_app/src/shared/models/seller.model.dart';

class Report {
  final String boatName;
  final Partner partner;
  final Seller seller;

  Report({
    required this.boatName,
    required this.partner,
    required this.seller,
  });
}
