import 'package:sqflite/sqflite.dart' as sql;
import 'package:mktk_app/src/shared/models/seller.model.dart';
import 'package:mktk_app/src/shared/services/database.service.dart';

class SellerStorage {
  static const String _table = 'sellers';

  static Future<sql.Database> _database() async {
    return await DatabaseService.db(
      _table,
      '''
        CREATE TABLE $_table(
          id INTEGER,
          cpf TEXT,
          name TEXT,
          phone TEXT
        );
      ''',
    );
  }

  static Future<List<Map<String, dynamic>>> select() async {
    final db = await SellerStorage._database();
    List<Map<String, dynamic>> sellers = await db.query(_table);
    return sellers;
  }

  static Future<void> insert(Seller seller) async {
    final db = await SellerStorage._database();
    await db.insert(
      _table,
      seller.toMap(),
    );
  }

  static Future<void> deleteAll() async {
    final db = await SellerStorage._database();
    await db.rawDelete('DELETE FROM $_table;');
  }
}
