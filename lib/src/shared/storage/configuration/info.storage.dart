import 'package:mktk_app/src/shared/models/info.model.dart';
import 'package:mktk_app/src/shared/services/database.service.dart';
import 'package:sqflite/sqflite.dart' as sql;

class InfoStorage {
  static const String _table = 'info';
  InfoStorage();

  static Future<sql.Database> _database() {
    return DatabaseService.db(
      _table,
      '''
        CREATE TABLE $_table(
          boat TEXT,
          seller TEXT
        )
      ''',
    );
  }

  static Future<int> create(Info info) async {
    final db = await InfoStorage._database();
    final id = await db.insert(
      _table,
      info.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<int> edit(Info info) async {
    // get the field
    List<Map<String, dynamic>> item = await InfoStorage.getInfo();
    String boat = item[0]['boat'];
    // update the field
    final db = await InfoStorage._database();
    return await db.update(
      _table,
      info.toMap(),
      where: 'boat = ?',
      whereArgs: [boat],
    );
  }

  static Future<List<Map<String, dynamic>>> getInfo() async {
    final db = await InfoStorage._database();
    return db.query(_table, limit: 1);
  }
}
