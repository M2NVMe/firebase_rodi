
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AuthController.dart';

class AuthWrapper extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.firebaseUser.value != null) {
        Future.microtask(() => Get.offAllNamed("/utama"));
      } else {
        Future.microtask(() => Get.offAllNamed("/logintest"));
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
