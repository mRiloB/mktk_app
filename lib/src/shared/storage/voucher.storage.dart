import 'package:sqflite/sqflite.dart' as sql;
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/shared/services/database.service.dart';

class VoucherStorage {
  static const String _table = 'vouchers';

  static Future<sql.Database> _database() async {
    return await DatabaseService.db(
      _table,
      '''
        CREATE TABLE $_table(
          id INTEGER,
          name TEXT,
          server TEXT,
          profile TEXT,
          limit_uptime TEXT,
          payment TEXT,
          price REAL,
          created_at TEXT,
          updated_at TEXT
        );
      ''',
    );
  }

  static Future<List<Map<String, dynamic>>> select() async {
    final db = await VoucherStorage._database();
    List<Map<String, dynamic>> vouchers = await db.query(_table);
    return vouchers;
  }

  static Future<Map<String, dynamic>> selectByName(String name) async {
    final db = await VoucherStorage._database();
    List<Map<String, dynamic>> vouchers = await db.query(
      _table,
      where: 'name = ?',
      whereArgs: [name],
    );
    return vouchers.isNotEmpty ? vouchers.first : {};
  }

  static Future<void> insert(Voucher voucher) async {
    final db = await VoucherStorage._database();
    await db.insert(
      _table,
      voucher.toMap(),
    );
  }

  static Future<void> deleteAll() async {
    final db = await VoucherStorage._database();
    await db.rawDelete('DELETE FROM $_table;');
  }
}
