import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Controllers/PageControllers/ChangePageController.dart';
import 'package:firebase_rodi/Pages/Fragments/CompletedTask.dart';
import 'package:firebase_rodi/Pages/Fragments/ProfilePage.dart';
import 'package:firebase_rodi/Pages/Fragments/UtamaPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final Changepagecontroller changepagecontroller = Get.put(Changepagecontroller());
  final User? user = FirebaseAuth.instance.currentUser;
  List<Widget> Pages = [UtamaPage(), CompletedtaskPage(), Profilepage()];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Pages[changepagecontroller.selectedindex.value],
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              // Drawer Header - User Info Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color(0xFF212121)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      child: user?.photoURL == null
                          ? const Icon(Icons.person, size: 40, color: Colors.black)
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user?.displayName ?? 'John Doe',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? 'johndoe@gmail.com',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Navigation Items
              Expanded(
                child: Column(
                  children: [
                    _buildDrawerItem(
                      icon: Icons.list_alt_rounded,
                      title: 'Task',
                      isSelected: changepagecontroller.selectedindex.value == 0,
                      onTap: () {
                        changepagecontroller.changeMenu(0);
                        Navigator.pop(context);
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.fact_check_outlined,
                      title: 'Completed tasks',
                      isSelected: changepagecontroller.selectedindex.value == 1,
                      onTap: () {
                        changepagecontroller.changeMenu(1);
                        Navigator.pop(context);
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.face_5_outlined,
                      title: 'Profile',
                      isSelected: changepagecontroller.selectedindex.value == 2,
                      onTap: () {
                        changepagecontroller.changeMenu(2);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.black12,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black12 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
