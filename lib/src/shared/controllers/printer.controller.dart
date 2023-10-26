import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:mktk_app/src/shared/services/printer.service.dart';
import 'package:mktk_app/src/shared/storage/printer.storage.dart';

class PrinterController {
  static Future<BluetoothDevice?> getLocalDevice() async {
    List<Map<String, dynamic>> devices = await PrinterStorage.select();
    if (devices.isEmpty) return null;
    return devices
        .map(
          (bt) => BluetoothDevice.fromJson(
            {
              'name': bt['name'],
              'address': bt['address'],
            },
          ),
        )
        .first;
  }

  static Future<dynamic> saveLocal(BluetoothDevice device) async {
    await PrinterStorage.upinsert(device);
    await PrinterService.connect(device);
  }

  static Future<bool> connectLocalDevice() async {
    try {
      BluetoothDevice? device = await getLocalDevice();
      if (device == null) return false;
      // bool isConnected =
      //     await PrinterService.bluetoothPrint.isConnected ?? false;
      // if (isConnected) {
      await PrinterService.connect(device);
      await Future.delayed(const Duration(seconds: 3));
      await PrinterService.test();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> disconnectLocalDevice() async {
    await PrinterService.disconnect();
  }
}
