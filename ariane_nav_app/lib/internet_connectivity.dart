import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityReceiver extends StatefulWidget {
  @override
  _InternetConnectivityReceiverState createState() => _InternetConnectivityReceiverState();
}

class _InternetConnectivityReceiverState extends State<InternetConnectivityReceiver> {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.none;
    }
    if (!mounted) return;
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _connectivityResult = result;
    });

    String message;
    if (result == ConnectivityResult.mobile) {
      message = 'Connected to Mobile Network';
    } else if (result == ConnectivityResult.wifi) {
      message = 'Connected to WiFi';
    } else {
      message = 'No Internet Connection';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internet Connectivity Receiver'),
      ),
      body: Center(
        child: Text(
          'Connectivity Status: $_connectivityResult',
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
