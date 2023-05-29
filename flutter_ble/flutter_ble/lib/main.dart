import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothDemo extends StatelessWidget {
  const BluetoothDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Demo'),
      ),
      body: BluetoothBody(),
    );
  }
}

class BluetoothBody extends StatefulWidget {
  @override
  _BluetoothBodyState createState() => _BluetoothBodyState();
}

class _BluetoothBodyState extends State<BluetoothBody> {
  final List<BluetoothDevice> _devices = [];

  FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;
  StreamSubscription<List<ScanResult>>? _scanSubscription;

  // 搜索蓝牙设备
  void _startScan() {

    _scanSubscription = _flutterBlue.scanResults.listen((results) {
        // do something with scan results
        for (ScanResult r in results) {
            print('${r.device.name} found! rssi: ${r.rssi}');
            BluetoothDevice device = r.device;
          if (!_devices.contains(device)) {
            _devices.add(device);
          }
        }
    });
  }

  // 停止搜索蓝牙设备并断开连接
  void _stopScan() {
    _scanSubscription?.cancel();
    _devices.clear();
    _flutterBlue.stopScan();
  }

  // 连接蓝牙设备
  void _connectDevice(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);
      print('Connected to device ${device.id}');
    } catch (e) {
      print(e);
    }
  }

  // 断开蓝牙设备连接
  Future<void> _disconnectDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
      print('Disconnected from device ${device.id}');
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  @override
  void dispose() {
    _stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _devices.length,
      itemBuilder: (context, index) {
        final BluetoothDevice device = _devices[index];
        return ListTile(
          title: Text(device.name),
          subtitle: Text(device.id.toString()),
          trailing: ElevatedButton(
            child: const Text('Connect'),
            onPressed: () => _connectDevice(device),
          ),
        );
      },
    );
  }
}