import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:mktk_app/src/shared/services/database.service.dart';

class PrinterStorage {
  static const String _table = 'printer';

  static Future<sql.Database> _database() async {
    return await DatabaseService.db(
      _table,
      '''
        CREATE TABLE $_table(
          id INTEGER,
          name TEXT,
          address TEXT
        );
      ''',
    );
  }

  static Future<List<Map<String, dynamic>>> select() async {
    final db = await PrinterStorage._database();
    List<Map<String, dynamic>> printers = await db.query(_table);
    return printers;
  }

  static Future<void> upinsert(BluetoothDevice device) async {
    final db = await PrinterStorage._database();
    await deleteAll();
    await db.insert(
      _table,
      {
        'name': device.name,
        'address': device.address,
      },
    );
  }

  static Future<void> deleteAll() async {
    final db = await PrinterStorage._database();
    await db.rawDelete('DELETE FROM $_table;');
  }
}
