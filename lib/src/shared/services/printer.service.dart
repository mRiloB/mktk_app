import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:intl/intl.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';

String dateFmt(String date) {
  DateTime ldate = DateTime.parse(date);

  return DateFormat('dd/MM/yyyy H:m:s').format(ldate);
}

class PrinterService {
  static Future<dynamic> printVoucher(Voucher voucher,
      [bool again = false]) async {
    BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
    Map<String, dynamic> config = {};
    List<LineText> list = [];
    String printedAt = again
        ? dateFmt(DateTime.now().toString())
        : dateFmt(voucher.createdAt!);

    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Moby Tecnologia',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
    );

    list.add(LineText(
      linefeed: 1,
    ));

    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: voucher.name,
        weight: 0,
        height: 10,
        width: 10,
        align: LineText.ALIGN_CENTER,
        fontZoom: 1,
        linefeed: 1,
      ),
    );

    list.add(LineText(
      linefeed: 1,
    ));

    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Valor: R\$ ${voucher.price}',
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
      ),
    );

    list.add(LineText(
      linefeed: 1,
    ));

    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Tempo de uso: ${voucher.profile}',
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
      ),
    );

    list.add(LineText(
      linefeed: 1,
    ));

    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Emitido em: $printedAt',
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
    );
    list.add(
      LineText(
        linefeed: 1,
      ),
    );

    await bluetoothPrint.printReceipt(config, list);
  }
}
