import '../../features/device_listing/model/bluetooth_device_model.dart';
import 'bluetooth_service.dart';

class MockBluetoothService implements BluetoothService {
  @override
  Future<bool> connect(String deviceId) async => true;

  @override
  Future<void> disconnect() async {}

  @override
  Stream<String> incomingMessages() => const Stream.empty();

  @override
  Future<bool> isBluetoothAvailable() async => true;

  @override
  Future<List<BluetoothDeviceModel>> scanDevices() async {
    return const [
      BluetoothDeviceModel(
        name: 'BlueChat Demo Device',
        address: '00:11:22:AA',
      ),
      BluetoothDeviceModel(name: 'Test Phone', address: '00:11:22:BB'),
    ];
  }

  @override
  Future<void> sendMessage(String text) async {}
}
