import 'package:mktk_app/src/shared/models/connection.model.dart';
import 'package:mktk_app/src/shared/services/database.service.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ConnectionStorage {
  static const String _table = 'connection';
  ConnectionStorage();

  static Future<sql.Database> _database() {
    return DatabaseService.db(
      _table,
      '''
        CREATE TABLE $_table(
          ip TEXT,
          login TEXT,
          password TEXT
        )
      ''',
    );
  }

  static Future<int> create(Connection conn) async {
    final db = await ConnectionStorage._database();
    final id = await db.insert(
      _table,
      conn.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<int> edit(Connection conn) async {
    // get the field
    List<Map<String, dynamic>> item = await ConnectionStorage.getConnection();
    String ip = item[0]['ip'];
    // update the field
    final db = await ConnectionStorage._database();
    return await db.update(
      _table,
      conn.toMap(),
      where: 'ip = ?',
      whereArgs: [ip],
    );
  }

  static Future<List<Map<String, dynamic>>> getConnection() async {
    final db = await ConnectionStorage._database();
    return db.query(_table, limit: 1);
  }
}
