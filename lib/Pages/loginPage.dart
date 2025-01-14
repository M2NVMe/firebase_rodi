import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebase_auth_implementation/firebase_auth_services.dart';
import '../global/common/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSigning = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;  // Add this line

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
            // Title
            Text(
              'Login to Your Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Email TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),

            // Password TextField
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),

            // Login Button
            ElevatedButton(
              onPressed: () {
                _signIn();
              },
              child: isSigning ? CircularProgressIndicator(color: Colors.white,): Text('Login'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20),

            // Google Sign-In Button (Optional)
            ElevatedButton.icon(
              onPressed: () {
                _signInWithGoogle();
              },
              icon: Icon(Icons.login),
              label: Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20),

            // Navigate to Register Page using GetX
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

  void _signIn() async {
    setState(() {
      isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is Successfully Signed In.");
      Get.toNamed(RoutePages.home);
    } else {
      showToast(message: "Some error occurred.");
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSingIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSingIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        //tes

        await _firebaseAuth.signInWithCredential(credential);  // Now using _firebaseAuth
        Get.toNamed(RoutePages.home);
      }
    } catch (e) {
      showToast(message: "Some error occurred: $e");
    }
  }
}

//loginPage