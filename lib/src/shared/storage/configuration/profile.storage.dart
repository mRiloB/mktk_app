import 'package:mktk_app/src/shared/models/profile.model.dart';
import 'package:mktk_app/src/shared/services/database.service.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ProfileStorage {
  static const String _table = 'profile';
  ProfileStorage();

  static Future<sql.Database> _database() {
    return DatabaseService.db(
      _table,
      '''
        CREATE TABLE $_table(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          mktk_id TEXT,
          name TEXT,
          limit_uptime TEXT,
          price REAL
        )
      ''',
    );
  }

  static Future<int> create(Profile profile) async {
    final db = await ProfileStorage._database();
    final id = await db.insert(
      _table,
      profile.toMap(true),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<int> edit(Profile profile) async {
    final db = await ProfileStorage._database();
    int id = await db.update(
      _table,
      profile.toMap(),
      where: 'id = ?',
      whereArgs: [profile.id],
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getInfo([bool all = false]) async {
    final db = await ProfileStorage._database();
    return db.query(_table, limit: all ? null : 1);
  }

  static Future<int> delete(Profile profile) async {
    final db = await ProfileStorage._database();
    int id = await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [profile.id],
    );
    return id;
  }
}
