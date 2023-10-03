import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mktk_app/src/shared/storage/boats.storage.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';

class BoatController {
  Future<List<Boat>> getSBBoats() async {
    List<Map<String, dynamic>> boats =
        await Supabase.instance.client.from('boats').select();

    return boats
        .map((boat) => Boat(
              id: boat['id'],
              abbr: boat['abbr'],
              name: boat['name'],
              partnerId: boat['partner_id'],
              sellerId: boat['seller_id'],
              posId: boat['pos_id'],
              connectionIp: boat['connection_ip'],
              connectionUser: boat['connection_user'],
            ))
        .toList();
  }

  Future<void> saveLocal(Boat boat) async {
    await BoatsStorage.create(boat);
  }

  Future<bool> existsLocal() async {
    Boat? boat = await BoatsStorage.select();
    if (boat != null) return true;
    return false;
  }

  Future<Boat> getLocalBoat() async {
    Boat? boat = await BoatsStorage.select();
    return boat!;
  }
}
