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
      User? user = await _authService.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        showToast(message: "User is Successfully Created");
        Get.toNamed(RoutePages.home);
      } else {
        showToast(message: "Some Error Occurred");
      }
    } finally {
      isSigning.value = false;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    isSigning.value = true;
    try {
      User? user = await _authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        showToast(message: "User is Successfully Signed In.");
        Get.toNamed(RoutePages.home);
      } else {
        showToast(message: "Some error occurred.");
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
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;

        if (user != null) {
          Get.toNamed(RoutePages.taskviewlist);
        }
      }
    } catch (e) {
      showToast(message: "Some error occurred: $e");
    } finally {
      isSigning.value = false;
    }
  }
}
