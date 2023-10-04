import 'package:sqflite/sqflite.dart' as sql;
import 'package:mktk_app/src/shared/services/database.service.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';

class PlanStorage {
  static const String _table = 'plans';

  static Future<sql.Database> _database() async {
    return await DatabaseService.db(
      _table,
      '''
        CREATE TABLE $_table(
          id INTEGER,
          name TEXT,
          price REAL
        );
      ''',
    );
  }

  static Future<List<Map<String, dynamic>>> select() async {
    final db = await PlanStorage._database();
    List<Map<String, dynamic>> plans = await db.query(_table);
    return plans;
  }

  static Future<void> insert(Plan plan) async {
    final db = await PlanStorage._database();
    await db.insert(
      _table,
      plan.toMap(),
    );
  }

  static Future<void> deleteAll() async {
    final db = await PlanStorage._database();
    await db.rawDelete('DELETE FROM $_table;');
  }
}
