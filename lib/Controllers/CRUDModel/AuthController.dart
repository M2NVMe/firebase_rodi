import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Pages/UtamaPage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
    auth.authStateChanges().listen((user) {
      print("Auth state changed: $user");
    });
  }

  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Account created successfully!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Logged in successfully!");
      print(firebaseUser);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.snackbar("Success", "Logged out successfully!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
