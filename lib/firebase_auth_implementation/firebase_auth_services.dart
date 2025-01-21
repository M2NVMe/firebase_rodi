import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/global/common/toast.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else if (e.code == 'weak-password') {
        showToast(message: 'The password is too weak. Please choose a stronger password.');
      } else if (e.code == 'invalid-email') {
        showToast(message: 'The email address is not valid.');
      } else {
        showToast(message: 'An error occurred: ${e.message}');
      }
    } catch (e) {
      showToast(message: 'Unknown error occurred: $e');
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast(message: 'Incorrect password.');
      } else if (e.code == 'invalid-email') {
        showToast(message: 'The email address is not valid.');
      } else {
        showToast(message: 'An error occurred: ${e.message}');
      }
    } catch (e) {
      showToast(message: 'Unknown error occurred: $e');
    }
    return null;
  }
}
