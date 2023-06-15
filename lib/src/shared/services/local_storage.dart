import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class LocalStorageService {
  final String table;
  late final LocalStorage storage;

  LocalStorageService(this.table) {
    storage = LocalStorage(table);
  }

  void save(String key, dynamic value) async {
    await storage.setItem(key, value);
  }

  dynamic show(String key) {
    return storage.getItem(key);
  }

  void clear() async {
    await storage.clear();
  }
}
