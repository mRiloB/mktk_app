import 'package:hive/hive.dart';
import 'package:mktk_app/src/shared/models/connection.model.dart';
import 'package:mktk_app/src/shared/models/info.model.dart';

class ConfigurationCollection {
  late Box collection;

  ConfigurationCollection() {
    collection = Hive.box('configuration');
  }

  void saveInfo(Info info) {
    collection.put(
      'info',
      {
        'boatName': info.boatName,
        'seller': info.seller,
      },
    );
  }

  void saveConnection(Connection conn) {
    collection.put(
      'connection',
      {
        'ip': conn.ip,
        'login': conn.login,
        'password': conn.password,
      },
    );
  }

  Info? getInfo() {
    Map<String, String> storedInfo = collection.get('info');
    return Info(storedInfo['boatName'], storedInfo['seller']);
  }

  Connection? getConnection() {
    Map<String, String> storedConn = collection.get('connection');
    return Connection(
        storedConn['ip'], storedConn['login'], storedConn['password']);
  }
}
