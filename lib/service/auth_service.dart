import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_life/model/user.dart';
import 'package:fit_life/service/database_service.dart';

class AuthService {
  // Private static instance of AuthService
  static final AuthService _instance = AuthService._internal();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // DatabaseService instance
  final DatabaseService _databaseService = DatabaseService();

  // Private constructor
  AuthService._internal();

  // Global access point to the singleton instance
  static AuthService get instance => _instance;

  // Sign in with email & password
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return {'status': true};
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Authentication errors
      String errorMessage;
      if (e.code == 'invalid-credential') {
        errorMessage = "Invalid email or password. Please try again.";
      } else {
        errorMessage = "An error occurred. Please try again.";
      }
      return {'status': false, 'message': errorMessage};
    }
  }

  // Sign up user
  Future<bool> register(
      String name, String email, String password, String specialization) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = TrainerModel(
        uid: result.user!.uid,
        email: email,
        name: name,
        specialization: specialization,
      );

      await _databaseService.saveUserData(user);

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
