import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  bool get isLoggedIn => _user != null;
  User? get currentUser => _user;

  AuthProvider() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'weak-password':
          errorMessage = 'Your password should be at least 8 characters long and include a mix of letters, numbers, and special characters (e.g., @, #, %).';
          break;
        default:
          errorMessage = 'An unknown error occurred. Please try again.';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Sign-up failed: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _user = _firebaseAuth.currentUser;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email address. Please check your email or sign up.';
          break;
        case 'wrong-password':
          errorMessage = 'The password is incorrect. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid. Please check the format.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Check your email and password and try again.';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Sign-in failed: $e');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }
}
