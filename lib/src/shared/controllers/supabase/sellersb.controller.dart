import 'package:mktk_app/src/shared/models/seller.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SellerSBController {
  Future<Seller> getSellerById(int id) async {
    List<Map<String, dynamic>> sellers =
        await Supabase.instance.client.from('sellers').select();
    Seller seller = sellers
        .map(
          (sel) => Seller(
            id: sel['id'],
            cpf: sel['cpf'],
            name: sel['name'],
            phone: sel['phone'],
          ),
        )
        .firstWhere((sel) => sel.id == id);
    return seller;
  }
}
