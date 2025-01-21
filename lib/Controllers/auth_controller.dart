import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../firebase_auth_implementation/firebase_auth_services.dart';
import '../global/common/toast.dart';
import '../Routes/Route.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final RxBool isSigning = false.obs;

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    isSigning.value = true;
    try {
      // Make sure to validate the email and password before sending them to Firebase
      if (email.isEmpty || password.isEmpty) {
        showToast(message: "Email or Password cannot be empty");
        return;
      }

      User? user = await _authService.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        showToast(message: "User is Successfully Created");
        Get.offNamed(RoutePages.home);
      } else {
        showToast(message: "Some Error Occurred");
      }
    } catch (e) {
      // Catch FirebaseAuthException to handle specific errors
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            showToast(message: "The email address is already in use.");
            break;
          case 'weak-password':
            showToast(message: "The password is too weak.");
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
    } finally {
      isSigning.value = false;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    isSigning.value = true;
    try {
      if (email.isEmpty || password.isEmpty) {
        showToast(message: "Email or Password cannot be empty");
        return;
      }

      User? user = await _authService.signInWithEmailAndPassword(email, password);

      if (user != null) {
        showToast(message: "User is Successfully Signed In.");
        Get.offNamed(RoutePages.home);
      } else {
        showToast(message: "Some error occurred.");
      }
    } catch (e) {
      // Catch FirebaseAuthException to handle specific errors
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
          Get.offNamed(RoutePages.home);
        }
      }
    } catch (e) {
      showToast(message: "Some error occurred: $e");
    } finally {
      isSigning.value = false;
    }
  }
}
