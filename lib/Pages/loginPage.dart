import 'package:firebase_rodi/Routes/Route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_rodi/Controllers/auth_controller.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
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
                        color: Color(0xff313131),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),

                // Email Header
                _buildHeader('Email'),
                CustomTextField(
                  hintText: 'Enter your email',
                  controller: _authController.emailController,
                  onChanged: (value) {}, // Placeholder to keep existing functionality
                  borderColor: Color(0xff9A9A9A),
                  textColor: Color(0xff313131),
                  borderRadius: 14,
                ),
                SizedBox(height: 24),

                // Password Header
                _buildHeader('Password'),
                Obx(() {
                  return CustomTextField(
                    hintText: 'Enter your password',
                    controller: _authController.passwordController,
                    obscureText: !_authController.isPasswordVisible.value,
                    onChanged: (value) {}, // Placeholder to keep existing functionality
                    borderColor: Color(0xff9A9A9A),
                    textColor: Color(0xff313131),
                    borderRadius: 14,
                    maxLines: 1,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _authController.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: _authController.togglePasswordVisibility,
                    ),
                  );
                }),
                SizedBox(height: 32),

                // Login Button
                Obx(() {
                  return CustomButton(
                    text: _authController.isSigning.value
                        ? 'Signing In...'
                        : 'Log in',
                    onPressed: _authController.isSigning.value
                        ? null
                        : () => _authController.signInWithEmailAndPassword(),
                    backgroundColor: Color(0xff313131),
                    textColor: Colors.white,
                    textSize: 16,
                    fontWeight: FontWeight.w600,
                    buttonType: ButtonType.elevated,
                    borderWidth: 0,
                    borderColor: Color(0xff313131),
                    buttonWidth: 365,
                    buttonHeight: 50,
                    borderRadius: 14,
                  );
                }),
                SizedBox(height: 24),

                // Divider with "Or"
                Text(
                  'Or',
                  style: GoogleFonts.inter(fontSize: 14, color: Color(0xff313131)),
                ),
                SizedBox(height: 24),

                // Google Sign-In Button
                CustomButton(
                  text: 'Continue with Google',
                  onPressed: () => _authController.signInWithGoogle(),
                  backgroundColor: Color(0xffF4F4F5),
                  textColor: Color(0xff313131),
                  textSize: 16,
                  fontWeight: FontWeight.w600,
                  buttonType: ButtonType.elevated,
                  borderWidth: 1,
                  borderColor: Color(0xffF4F4F5),
                  buttonWidth: 365,
                  buttonHeight: 50,
                  borderRadius: 14,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Image.asset(
                      'lib/assets/images/google.png',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                SizedBox(height: 94),

                // Sign-Up Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Color(0xff313131),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(RoutePages.register),
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Color(0xff313131),
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

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff4D4D4D),
          ),
        ),
      ),
    );
  }
}