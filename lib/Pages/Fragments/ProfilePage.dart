import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Controllers/auth_controller.dart';
import 'package:firebase_rodi/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilepage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: Image.asset(
                'lib/assets/images/burger.png',
                height: 24,
                width: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                Image.asset(
                  'lib/assets/images/logo.png',
                  height: 32,
                  width: 32,
                ),
                const SizedBox(width: 8),
                Text(
                  "Just do it.",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: user != null
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.black12,
              backgroundImage: user!.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user!.photoURL == null
                  ? Icon(
                Icons.person,
                size: 100,
                color: Colors.white,
              )
                  : null,
            ),
            const SizedBox(height: 48),
            Text(
              "Name",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user!.displayName ?? 'John Doe',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Email",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user!.email ?? 'johndoe@gmail.com',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[500],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: CustomButton(
                text: "Log out",
                onPressed: () {
                  _authController.signOut();
                },
                backgroundColor: Color(0xFF893D3D),
                textColor: Colors.white,
                textSize: 18,
                fontWeight: FontWeight.w600,
                buttonType: ButtonType.elevated,
                borderWidth: 0,
                borderColor: Colors.transparent,
                buttonWidth: 130,
                buttonHeight: 56,
                borderRadius: 12,
                prefixIcon: null,
              ),
            ),
          ],
        ),
      )
          : const Center(child: Text('No user is signed in')),
    );
  }
}