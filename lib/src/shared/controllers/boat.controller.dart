import 'package:mktk_app/src/shared/storage/boat.storage.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';

class BoatController {
  Future<Boat?> getBoat() async {
    List<Map<String, dynamic>> boats = await BoatStorage.select();
    if (boats.isEmpty) return null;
    return Boat(
      id: boats.first['id'],
      abbr: boats.first['abbr'],
      name: boats.first['name'],
      connectionIp: boats.first['connection_ip'],
      connectionUser: boats.first['connection_user'],
      partnerId: boats.first['partner_id'],
      sellerId: boats.first['seller_id'],
    );
  }

  Future<void> save(Boat boat) async {
    await BoatStorage.insert(boat);
  }

  Future<void> clear() async {
    await BoatStorage.deleteAll();
  }
}
