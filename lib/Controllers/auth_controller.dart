import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../firebase_auth_implementation/firebase_auth_services.dart';
import '../global/common/toast.dart';
import '../Routes/Route.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Reactive state variables
  final RxBool isSigning = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signUpWithEmailAndPassword() async {
    isSigning.value = true;
    try {
      String email = emailController.text.trim();
      String password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        showToast(message: "Email or Password cannot be empty");
        return;
      }

      User? user = await _authService.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        showToast(message: "User is Successfully Created");

        // After successful sign-up, you can dispose of the controllers if you want
        // (not necessary to do here if you're navigating away and it's handled in onClose)
        // Get.delete<AuthController>();  // If you no longer need the controller
        Get.offNamed(RoutePages.home);
      } else {
        showToast(message: "Some Error Occurred");
      }
    } catch (e) {
      handleAuthError(e);
    } finally {
      isSigning.value = false;
    }
  }


  Future<void> signInWithEmailAndPassword() async {
    isSigning.value = true;
    try {
      String email = emailController.text.trim();
      String password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        showToast(message: "Email or Password cannot be empty");
        return;
      }

      User? user = await _authService.signInWithEmailAndPassword(email, password);

      if (user != null) {
        showToast(message: "User is Successfully Signed In.");

        // After successful sign-in, you can dispose of the controllers if you want
        // (not necessary to do here if you're navigating away and it's handled in onClose)
        Get.delete<AuthController>();  // If you no longer need the controller
        Get.offNamed(RoutePages.home);
      } else {
        showToast(message: "Some error occurred.");
      }
    } catch (e) {
      handleAuthError(e);
    } finally {
      isSigning.value = false;
    }
  }


  Future<void> signInWithGoogle() async {
    isSigning.value = true;
    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;

        if (user != null) {
          // Get.delete<AuthController>();
          Get.offNamed(RoutePages.home);
        }
      }
    } catch (e) {
      showToast(message: "Some error occurred: $e");
    } finally {
      isSigning.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Sign out from Google (if the user was logged in with Google)
      await GoogleSignIn().signOut();

      // After sign out, navigate to the login page
      Get.offAllNamed(RoutePages.login);
    } catch (e) {
      // Handle errors during sign out if necessary
      showToast(message: "Error signing out: $e");
    }
  }


  void handleAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          showToast(message: "No user found for that email.");
          break;
        case 'wrong-password':
          showToast(message: "Incorrect password.");
          break;
        case 'invalid-email':
          showToast(message: "The email address is invalid.");
          break;
        default:
          showToast(message: "Error: ${e.message}");
      }
    } else {
      showToast(message: "Some error occurred: $e");
    }
  }

  // @override
  // void onClose() {
  //   // Dispose controllers when the controller is destroyed
  //   usernameController.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}


