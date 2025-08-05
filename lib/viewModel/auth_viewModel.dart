import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_life/model/user.dart';
import 'package:fit_life/service/auth_service.dart';
import 'package:fit_life/service/database_service.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService.instance;
  final DatabaseService _dbService = DatabaseService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TrainerModel? _user;

  TrainerModel? get user => _user;

  Future<void> saveCurrentLoginUser() async {
    User? firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser != null) {
      _user = await _dbService.fetchUserData(firebaseUser.uid);
      print("User is saved.");

      notifyListeners();
    } else {
      _user = null;
    }
  }

  // Login function
  Future<Map<String, dynamic>> login(String email, String password) async {
    final messageMap = await _authService.login(email, password);

    notifyListeners();
    return messageMap; // Return success or failure
  }

  Future<bool> signup(
      String name, String email, String password, String specialization) async {
    bool isSignupSuccess =
        await _authService.register(name, email, password, specialization);
    notifyListeners();
    return isSignupSuccess;
  }

  // Logout function
  Future<void> logout() async {
    await _authService.logout();

    notifyListeners();
  }
}
