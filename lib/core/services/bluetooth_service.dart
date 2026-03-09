import '../../features/device_listing/model/bluetooth_device_model.dart';

abstract class BluetoothService {
  Future<bool> isBluetoothAvailable();
  Future<List<BluetoothDeviceModel>> scanDevices();
  Future<bool> connect(String deviceId);
  Future<void> disconnect();
  Stream<String> incomingMessages();
  Future<void> sendMessage(String text);
}
