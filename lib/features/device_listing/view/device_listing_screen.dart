import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chat/view/chat_screen.dart';
import '../model/bluetooth_device_model.dart';
import '../view_model/device_listing_view_model.dart';
import '../widget/device_tile.dart';

class DeviceListingScreen extends StatefulWidget {
  const DeviceListingScreen({super.key});

  @override
  State<DeviceListingScreen> createState() => _DeviceListingScreenState();
}

class _DeviceListingScreenState extends State<DeviceListingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DeviceListingViewModel>().initialize();
      context.read<DeviceListingViewModel>().scanDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DeviceListingViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Devices')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vm.isBluetoothAvailable ? 'Bluetooth: On' : 'Bluetooth: Off',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              if (vm.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    vm.errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              Expanded(
                child: vm.devices.isEmpty && !vm.isScanning
                    ? const Center(child: Text('No devices found'))
                    : ListView.builder(
                        itemCount: vm.devices.length,
                        itemBuilder: (context, index) {
                          final BluetoothDeviceModel device = vm.devices[index];
                          return DeviceTile(
                            device: device,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => ChatScreen(device: device),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: vm.isScanning ? null : vm.scanDevices,
        icon: vm.isScanning
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.bluetooth_searching),
        label: Text(vm.isScanning ? 'Scanning...' : 'Scan'),
      ),
    );
  }
}
