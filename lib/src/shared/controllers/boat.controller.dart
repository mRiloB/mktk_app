import 'package:mktk_app/src/shared/storage/boat.storage.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';

class BoatController {
  Future<Boat?> getBoat() async {
    List<Map<String, dynamic>> boats = await BoatStorage.select();
    if (boats.isEmpty) return null;
    return Boat(
      abbr: boats.first['abbr'],
      name: boats.first['name'],
    );
  }

  Future<void> save(Boat boat) async {
    await BoatStorage.insert(boat);
  }

  Future<void> clear() async {
    await BoatStorage.deleteAll();
  }
}
