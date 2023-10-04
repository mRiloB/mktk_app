import 'package:mktk_app/src/shared/models/seller.model.dart';
import 'package:mktk_app/src/shared/storage/seller.storage.dart';

class SellerController {
  Future<Seller?> getBoat() async {
    List<Map<String, dynamic>> sellers = await SellerStorage.select();
    if (sellers.isEmpty) return null;
    return Seller(
      cpf: sellers.first['cpf'],
      name: sellers.first['name'],
      phone: sellers.first['phone'],
    );
  }

  Future<void> save(Seller seller) async {
    await SellerStorage.insert(seller);
  }

  Future<void> clear() async {
    await SellerStorage.deleteAll();
  }
}
