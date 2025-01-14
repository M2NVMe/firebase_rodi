import 'package:firebase_rodi/controllers/auth_controller.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login to Your Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: _authController.isSigning.value
                  ? null
                  : () {
                _authController.signInWithEmailAndPassword(
                  _emailController.text,
                  _passwordController.text,
                );
              },
              child: _authController.isSigning.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Login'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            )),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _authController.signInWithGoogle();
              },
              icon: Icon(Icons.login),
              label: Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.toNamed(RoutePages.register);
              },
              child: Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}