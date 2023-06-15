import 'package:sqflite/sqflite.dart' as sql;

class DatabaseService {
  static Future<void> _createTables(sql.Database database, String query) async {
    await database.execute(query);
  }

  static Future<sql.Database> db(String table, String queryCreate) async {
    return sql.openDatabase(
      '$table.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await _createTables(database, queryCreate);
      },
    );
  }
}
