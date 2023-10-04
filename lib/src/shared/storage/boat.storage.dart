import 'package:sqflite/sqflite.dart' as sql;
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/services/database.service.dart';

class BoatStorage {
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

  static Future<List<Map<String, dynamic>>> select() async {
    final db = await BoatStorage._database();
    List<Map<String, dynamic>> boats = await db.query(_table);
    return boats;
  }

  static Future<void> insert(Boat boat) async {
    final db = await BoatStorage._database();
    await db.insert(
      _table,
      boat.toMap(),
    );
  }

  static Future<void> deleteAll() async {
    final db = await BoatStorage._database();
    await db.rawDelete('DELETE FROM $_table;');
  }
}
