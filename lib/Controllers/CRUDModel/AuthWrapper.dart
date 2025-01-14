
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AuthController.dart';

class AuthWrapper extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.firebaseUser.value != null) {
        Future.microtask(() => Get.offAllNamed(RoutePages.utama));
      } else {
        Future.microtask(() => Get.offAllNamed(RoutePages.logintest));
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
