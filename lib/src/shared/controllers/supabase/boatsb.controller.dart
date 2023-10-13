import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/models/partner.model.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';
import 'package:mktk_app/src/shared/models/seller.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BoatSBController {
  Future<List<Boat>> getBoats() async {
    List<Map<String, dynamic>> boats =
        await Supabase.instance.client.from('boats').select();

    return boats
        .map(
          (boat) => Boat(
            id: boat['id'],
            abbr: boat['abbr'],
            name: boat['name'],
            partnerId: boat['partner_id'],
            sellerId: boat['seller_id'],
            posId: boat['pos_id'],
            connectionIp: boat['connection_ip'],
            connectionUser: boat['connection_user'],
          ),
        )
        .toList();
  }

  Future<Report> getBoatsAndForeign(String abbr) async {
    List<dynamic> boats = await Supabase.instance.client.from('boats').select(
      '''
      name,
      partner(cnpj, name, address, owner),
      sellers(cpf, name)
      ''',
    ).eq('abbr', abbr);
    return Report(
      boatName: boats.first['name'],
      partner: Partner(
        cnpj: boats.first['partner']['cnpj'],
        name: boats.first['partner']['name'],
        address: boats.first['partner']['address'],
        owner: boats.first['partner']['name'],
      ),
      seller: Seller(
        cpf: boats.first['sellers']['cpf'],
        name: boats.first['sellers']['name'],
        phone: '',
      ),
    );
  }
}
