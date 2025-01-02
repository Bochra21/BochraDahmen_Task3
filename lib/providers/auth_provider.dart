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
    } catch (e) {
      throw Exception('Sign-up failed: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _user = _firebaseAuth.currentUser;
      notifyListeners();
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
