import 'package:sqflite/sqflite.dart' as sql;
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/services/database.service.dart';

class BoatsStorage {
  static const String _table = 'boats';

  static Future<sql.Database> _database() async {
    return await DatabaseService.db(
      _table,
      '''
        CREATE TABLE $_table(
          id INTEGER,
          abbr TEXT,
          name TEXT,
          partner_id INTEGER,
          seller_id INTEGER,
          pos_id INTEGER,
          connection_ip TEXT,
          connection_user TEXT
        );
      ''',
    );
  }

  static Future<int> create(Boat boat) async {
    final db = await BoatsStorage._database();
    final id = await db.insert(
      _table,
      boat.toMap(),
    );
    return id;
  }

  static Future<int> update(Boat boat) async {
    final db = await BoatsStorage._database();
    return await db.update(
      _table,
      boat.toMap(),
      where: 'abbr = ?',
      whereArgs: [boat.abbr],
    );
  }

  static Future<Boat?> select() async {
    final db = await BoatsStorage._database();
    List<Map<String, dynamic>> localBoat = await db.query(_table);
    if (localBoat.isEmpty) return null;
    return Boat(
      id: localBoat[0]['id'],
      abbr: localBoat[0]['abbr'],
      name: localBoat[0]['name'],
      partnerId: localBoat[0]['partner_id'],
      sellerId: localBoat[0]['seller_id'],
      posId: localBoat[0]['pos_id'],
      connectionIp: localBoat[0]['connection_ip'],
      connectionUser: localBoat[0]['connection_user'],
    );
  }
}
