import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_rodi/Routes/Route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _checkUserLoginStatus(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Get.offNamed(RoutePages.home);
    } else {
      Get.offNamed(RoutePages.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Triggering user login status check on widget build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserLoginStatus(context);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'lib/assets/images/logo.png',
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
