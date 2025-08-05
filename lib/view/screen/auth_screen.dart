import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_life/view/screen/dashboard_screen.dart';
import 'package:fit_life/view/screen/login_screen.dart';
import 'package:flutter/material.dart';

bool isLogin = false;

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user != null) {
            print(user.toString());
            isLogin = true;
            return DashboardScreen();
          } else {
            isLogin = false;
            return LoginScreen();
          }
        }

        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
