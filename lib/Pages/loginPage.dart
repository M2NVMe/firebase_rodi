import 'package:firebase_rodi/Routes/Route.dart';
import 'package:firebase_rodi/global/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:firebase_rodi/Widgets/custom_button.dart';
import 'package:firebase_rodi/Widgets/custom_text_field.dart';
import 'package:firebase_rodi/Controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Create an instance of AuthController
  final AuthController _authController = Get.put(AuthController());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),

                // Logo and Title in a Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/logo.png',
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Just do it.',
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                // Email Header and TextField with slight alignment to the right
                Padding(
                  padding: const EdgeInsets.only(left: 16.0), // Add padding for header alignment
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity, // Full width of the parent container
                  child: CustomTextField(
                    hintText: 'Enter your email',
                    controller: _emailController,
                    onChanged: (value) {},
                    borderColor: Colors.grey,
                    textColor: Colors.black,
                    borderRadius: 16,
                  ),
                ),

                SizedBox(height: 24),

                // Password Header and TextField with slight alignment to the right
                Padding(
                  padding: const EdgeInsets.only(left: 16.0), // Add padding for header alignment
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity, // Full width of the parent container
                  child: CustomTextField(
                    borderRadius: 16,
                    hintText: 'Enter your password',
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    onChanged: (value) {},
                    borderColor: Colors.grey,
                    textColor: Colors.black,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 32),

                // Login Button
                Obx(() {
                  // Display loading indicator while logging in
                  return CustomButton(
                    text: _authController.isSigning.value ? 'Signing In...' : 'Log in',
                    onPressed: _authController.isSigning.value
                        ? null // Disable the button while signing in
                        : () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      if (email.isNotEmpty && password.isNotEmpty) {
                        await _authController.signInWithEmailAndPassword(email, password);
                      } else {
                        showToast(message: "Please enter email and password.");
                      }
                    },
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textSize: 16,
                    buttonType: ButtonType.elevated,
                    borderWidth: 0,
                    borderColor: Colors.black,
                    buttonWidth: 365,  // Custom width for the button
                    buttonHeight: 50,  // Custom height for the button
                    borderRadius: 16,
                  );
                }),

                SizedBox(height: 24),

                // Divider with "Or"
                Text(
                  'Or',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 24),

                // Google Sign-In Button
                CustomButton(
                  text: 'Continue with Google',
                  onPressed: () async {
                    await _authController.signInWithGoogle();
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  textSize: 16,
                  buttonType: ButtonType.elevated,
                  borderWidth: 1,
                  borderColor: Colors.grey,
                  buttonWidth: 365,  // Custom width for the button
                  buttonHeight: 50,  // Custom height for the button
                  borderRadius: 16,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Image.asset(
                      'lib/assets/images/google.png',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Sign-Up Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutePages.register); // Navigate to Register page
                      },
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
