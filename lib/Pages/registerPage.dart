import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/auth_controller.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            Text(
              'Registration',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff313131),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0), // Correct usage of padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create a',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff313131),
                          ),
                        ),
                        Text(
                          'New Account',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff313131),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32),

                // Username Header and TextField
                _buildHeader('Username'),
                CustomTextField(
                  hintText: 'Enter your username',
                  controller: _authController.usernameController,
                  onChanged: (value) {},
                  borderColor: Color(0xff9A9A9A),
                  textColor: Color(0xff313131),
                  borderRadius: 14,
                  height: 10,
                ),
                SizedBox(height: 14),

                // Email Header and TextField
                _buildHeader('Email'),
                CustomTextField(
                  hintText: 'Enter your email',
                  controller: _authController.emailController,
                  onChanged: (value) {},
                  borderColor: Color(0xff9A9A9A),
                  textColor: Color(0xff313131),
                  borderRadius: 14,
                  height: 10,
                ),
                SizedBox(height: 14),

                // Password Header and TextField
                _buildHeader('Password'),
                Obx(() {
                  return CustomTextField(
                    hintText: 'Enter your password',
                    controller: _authController.passwordController,
                    obscureText: !_authController.isPasswordVisible.value,
                    onChanged: (value) {},
                    borderColor: Color(0xff9A9A9A),
                    textColor: Color(0xff313131),
                    borderRadius: 14,
                    height: 10,
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

                // Sign-Up Button
                Obx(() {
                  return CustomButton(
                    text: _authController.isSigning.value
                        ? 'Signing Up...'
                        : 'Sign up',
                    onPressed: _authController.isSigning.value
                        ? null
                        : () => _authController.signUpWithEmailAndPassword(),
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
                SizedBox(height: 18),

                // Divider with "Or"
                Text(
                  'Or',
                  style: GoogleFonts.inter(fontSize: 14, color: Color(0xff313131)),
                ),
                SizedBox(height: 18),

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
                SizedBox(height: 27),

                // Navigation to Login Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Color(0xff313131),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        'Log in',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Color(0xff313131),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
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
