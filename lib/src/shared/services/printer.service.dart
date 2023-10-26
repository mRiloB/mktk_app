import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mktk_app/src/shared/models/report.model.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';

String dateFmt(String date) {
  DateTime ldate = DateTime.parse(date);

  return DateFormat('dd/MM/yyyy H:m:s').format(ldate);
}

class PrinterService {
  static BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  static Future<bool> isConnected() async =>
      await bluetoothPrint.isConnected ?? false;

  static Future<List<BluetoothDevice>> getDevices() async {
    bool isConnected = await bluetoothPrint.isConnected ?? false;
    debugPrint('=== antes');
    List<BluetoothDevice> btList =
        await bluetoothPrint.startScan(timeout: const Duration(seconds: 5));
    debugPrint('=== depois');
    debugPrint('=== isConnected: $isConnected');
    return btList;
  }

  static Future<dynamic> connect(BluetoothDevice device) async {
    await bluetoothPrint.connect(device);
  }

  static Future<dynamic> disconnect() async {
    await bluetoothPrint.disconnect();
  }

  static Future<dynamic> test() async {
    Map<String, dynamic> config = {};
    List<LineText> list = [];
    list.add(LineText(linefeed: 1));
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'impressora ta funcionando',
      ),
    );
    list.add(LineText(linefeed: 1));
    list.add(LineText(linefeed: 1));
    await bluetoothPrint.printReceipt(config, list);
  }

  static Future<dynamic> printVoucher(Voucher voucher,
      [bool again = false]) async {
    bool isConn = await isConnected();
    if (!isConn) return;
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
        linefeed: 1,
      ),
    );

    list.add(LineText(
      linefeed: 1,
    ));

    String printDate = "${again ? 'Reimpresso' : 'Emitido'} em: $printedAt";

    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: printDate,
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

  static Future<dynamic> printReport(
      Report report, String ttQtd, String total) async {
    bool isConn = await isConnected();
    if (!isConn) return;
    Map<String, dynamic> config = {};
    List<LineText> list = [];
    String printedAt = dateFmt(DateTime.now().toString());

    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Moby Tecnologia',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
    );
    list.add(LineText(linefeed: 1));
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: report.boatName,
        weight: 1,
        linefeed: 1,
      ),
    );
    list.add(LineText(linefeed: 1));
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Caixa:',
        linefeed: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_RIGHT,
        content: report.seller!.name,
        linefeed: 1,
      ),
    );
    list.add(LineText(linefeed: 1));
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Referencia:',
        linefeed: 1,
        weight: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_RIGHT,
        content: report.reference,
        linefeed: 1,
      ),
    );
    list.add(LineText(linefeed: 1));
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_CENTER,
        content: 'Tipo de Pagamento',
        linefeed: 1,
      ),
    );
    list.add(LineText(linefeed: 1));
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Dinheiro:',
        linefeed: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_RIGHT,
        content: 'R\$ ${report.dinheiro['total']}',
        linefeed: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Debito',
        linefeed: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_RIGHT,
        content: 'R\$ ${report.debito['total']}',
        linefeed: 1,
      ),
    );

    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Credito:',
        linefeed: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_RIGHT,
        content: 'R\$ ${report.credito['total']}',
        linefeed: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'PIX:',
        linefeed: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_RIGHT,
        content: 'R\$ ${report.pix['total']}',
        linefeed: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'TOTAL:',
        linefeed: 1,
        weight: 1,
      ),
    );
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_RIGHT,
        content: 'R\$ ${report.total.toString()}',
        linefeed: 1,
        weight: 1,
      ),
    );
    list.add(LineText(linefeed: 1));

    if (report.plans != null) {
      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          align: LineText.ALIGN_CENTER,
          content: 'Plano de Acesso',
          linefeed: 1,
        ),
      );
      list.add(LineText(linefeed: 1));
      for (var plan in report.plans!.entries) {
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: "${plan.key} (${plan.value['qtd']}):",
            linefeed: 1,
            weight: 1,
          ),
        );
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            align: LineText.ALIGN_RIGHT,
            content: "R\$ ${plan.value['total']}",
            linefeed: 1,
            weight: 1,
          ),
        );
      }

      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "TOTAL ($ttQtd):",
          linefeed: 1,
          weight: 1,
        ),
      );
      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          align: LineText.ALIGN_RIGHT,
          content: "R\$ $total",
          linefeed: 1,
          weight: 1,
        ),
      );
    }

    list.add(LineText(linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_CENTER,
        content: printedAt,
        linefeed: 1,
      ),
    );
    list.add(LineText(linefeed: 1));

    await bluetoothPrint.printReceipt(config, list);
  }
}
