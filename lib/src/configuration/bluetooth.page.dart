import 'package:flutter/material.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> _scanBluetooth() async {
    try {
      await bluetoothPrint.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      debugPrint('Verifique se o bluetooth está ligado!');
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    await _scanBluetooth();
    try {
      bool isConnected = await bluetoothPrint.isConnected ?? false;

      bluetoothPrint.scanResults.listen((event) {
        debugPrint('******************* cur devices: $event');
      });

      bluetoothPrint.state.listen((state) {
        debugPrint('******************* cur device status: $state');

        switch (state) {
          case BluetoothPrint.CONNECTED:
            setState(() {
              _connected = true;
              tips = 'connect success';
            });
            break;
          case BluetoothPrint.DISCONNECTED:
            setState(() {
              _connected = false;
              tips = 'disconnect success';
            });
            break;
          default:
            break;
        }
      });

      if (!mounted) return;

      if (isConnected) {
        setState(() {
          _connected = true;
        });
      }
    } catch (e) {
      debugPrint('Verifique se o bluetooth está ligado! 2');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            'Bluetooth',
            style: TextStyle(color: Colors.white),
          ),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              const Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: List.empty(growable: true),
                builder: (c, snapshot) {
                  debugPrint('=== c $c');
                  debugPrint('=== snap $snapshot');
                  return Column(
                    children: snapshot.data!
                        .map((d) => ListTile(
                              title: Text(d.name ?? ''),
                              subtitle: Text(d.address ?? ''),
                              onTap: () async {
                                setState(() {
                                  _device = d;
                                });
                              },
                              trailing: _device != null &&
                                      _device!.address == d.address
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                            ))
                        .toList(),
                  );
                },
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: _connected
                              ? null
                              : () async {
                                  if (_device != null &&
                                      _device!.address != null) {
                                    setState(() {
                                      tips = 'connecting...';
                                    });
                                    await bluetoothPrint.connect(_device!);
                                  } else {
                                    setState(() {
                                      tips = 'please select device';
                                    });
                                    debugPrint('please select device');
                                  }
                                },
                          child: const Text('connect'),
                        ),
                        const SizedBox(width: 10.0),
                        OutlinedButton(
                          onPressed: _connected
                              ? () async {
                                  setState(() {
                                    tips = 'disconnecting...';
                                  });
                                  await bluetoothPrint.disconnect();
                                }
                              : null,
                          child: const Text('disconnect'),
                        ),
                      ],
                    ),
                    const Divider(),
                    OutlinedButton(
                      onPressed: _connected
                          ? () async {
                              await bluetoothPrint.printTest();
                            }
                          : null,
                      child: const Text('print selftest'),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
