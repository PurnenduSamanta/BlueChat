import 'package:flutter/foundation.dart';

import '../../../core/services/bluetooth_service.dart';
import '../../../core/services/mock_bluetooth_service.dart';
import '../model/bluetooth_device_model.dart';

class DeviceListingViewModel extends ChangeNotifier {
  DeviceListingViewModel({BluetoothService? service}) {
    if (service != null) {
      _service = service;
    } else {
      _service = MockBluetoothService();
    }
  }

  late final BluetoothService _service;

  bool _isScanning = false;
  bool _isBluetoothAvailable = true;
  String? _errorMessage;
  List<BluetoothDeviceModel> _devices = const [];

  bool get isScanning => _isScanning;
  bool get isBluetoothAvailable => _isBluetoothAvailable;
  String? get errorMessage => _errorMessage;
  List<BluetoothDeviceModel> get devices => _devices;

  Future<void> initialize() async {
    _isBluetoothAvailable = await _service.isBluetoothAvailable();
    notifyListeners();
  }

  Future<void> scanDevices() async {
    _errorMessage = null;
    _isScanning = true;
    notifyListeners();

    try {
      _devices = await _service.scanDevices();
    } catch (_) {
      _errorMessage = 'Failed to scan nearby devices.';
    } finally {
      _isScanning = false;
      notifyListeners();
    }
  }
}
