import 'package:firebase_rodi/Controllers/CRUDModel/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Testlogin extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.login(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                authController.register(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
