import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/controllers/printer.controller.dart';
import 'package:mktk_app/src/shared/services/printer.service.dart';
import 'package:mktk_app/src/shared/widgets/error_dialog.dart';
import 'package:mktk_app/src/shared/widgets/list_card.dart';
import 'package:mktk_app/src/shared/widgets/mscaffold.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({super.key});

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  bool isLoading = false;
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    loadDevices();
  }

  void loadDevices() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<BluetoothDevice> aux = await PrinterService.getDevices();
      setState(() {
        devices = aux;
      });
    } catch (e) {
      debugPrint('=== printer error: ${e.toString()}');
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (BuildContext context) => ErrorDialog(
          message: e.toString(),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      isLoading: isLoading,
      children: [
        ...devices.map(
          (BluetoothDevice device) => ListCard(
            icon: Icons.bluetooth,
            title: device.name!,
            subtitle: device.address,
            onTap: () async {
              await PrinterController.saveLocal(device);
              final snackBar = SnackBar(
                content: const Text('Dispositivo conectado!'),
                action: SnackBarAction(
                  label: 'OK',
                  onPressed: () {},
                ),
              );
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ),
      ],
    );
  }
}
