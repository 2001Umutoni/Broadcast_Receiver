import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class BatteryChargingReceiver extends StatefulWidget {
  @override
  _BatteryChargingReceiverState createState() => _BatteryChargingReceiverState();
}

class _BatteryChargingReceiverState extends State<BatteryChargingReceiver> {
  final Battery _battery = Battery();
  late BatteryState _batteryState;
  int _batteryLevel = 0;
  final int _threshold = 90;

  @override
  void initState() {
    super.initState();
    _battery.onBatteryStateChanged.listen(_updateBatteryState);
    _checkInitialBatteryState();
  }

  Future<void> _checkInitialBatteryState() async {
    BatteryState batteryState;
    int batteryLevel;
    try {
      batteryState = await _battery.batteryState;
      batteryLevel = await _battery.batteryLevel;
    } catch (e) {
      batteryState = BatteryState.unknown;
      batteryLevel = 0;
    }
    if (!mounted) return;
    _updateBatteryState(batteryState);
    _updateBatteryLevel(batteryLevel);
  }

  void _updateBatteryState(BatteryState state) {
    setState(() {
      _batteryState = state;
    });
    if (state == BatteryState.charging) {
      _checkBatteryLevel();
    }
  }

  void _updateBatteryLevel(int level) {
    setState(() {
      _batteryLevel = level;
    });
    if (_batteryState == BatteryState.charging && _batteryLevel >= _threshold) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Battery reached $_threshold% while charging')),
      );
    }
  }

  void _checkBatteryLevel() async {
    int batteryLevel = await _battery.batteryLevel;
    _updateBatteryLevel(batteryLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Charging Receiver'),
      ),
      body: Center(
        child: Text(
          'Battery Level: $_batteryLevel%\nBattery State: $_batteryState',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
