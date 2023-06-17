import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/services/database.service.dart';
import 'package:sqflite/sqflite.dart' as sql;

class VoucherStorage {
  static const String _table = 'voucher';
  VoucherStorage();

  static Future<sql.Database> _database() {
    return DatabaseService.db(
      _table,
      '''
        CREATE TABLE $_table(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT,
          server TEXT,
          profile TEXT,
          limit_uptime TEXT,
          price REAL
        )
      ''',
    );
  }

  static Future<int> create(Voucher voucher) async {
    final db = await VoucherStorage._database();
    final id = await db.insert(
      _table,
      voucher.toMap(true),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getInfo(String name) async {
    final db = await VoucherStorage._database();
    return db.query(_table, where: 'name = ?', whereArgs: [name]);
  }
}
