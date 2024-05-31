import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'DashboardView is working',
                style: TextStyle(fontSize: 20),
              ),
              Text('Current Time: ${controller.now.value.toString()}'),
              Text('Page Life: ${controller.sec} seconds'),
              Container(height: 10),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/settings');
                },
                child: const Text('go Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
