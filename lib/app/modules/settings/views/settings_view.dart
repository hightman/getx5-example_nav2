import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'SettingsView is working',
              style: TextStyle(fontSize: 20),
            ),
            Container(height: 10),
            ElevatedButton(
              onPressed: () {
                controller.increment();
              },
              child: Obx(() => Text('clicked ${controller.count} times')),
            ),
            Container(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/home/dashboard');
              },
              child: const Text('go Dashboard'),
            ),
            Container(height: 3),
            const Text(
                'Try backing to settings page from dashboard, clicked count will be preserved.'),
          ],
        ),
      ),
    );
  }
}
