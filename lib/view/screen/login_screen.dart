import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/components/text_input_field.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/viewModel/auth_viewModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form key for validation

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 144, left: 40, right: 40),
            child: Center(
              child: Form(
                key: _formKey, // Assign the form key
                child: Column(
                  children: [
                    Text(
                      "FITLIFE",
                      style: kTitleStyle,
                    ),
                    Image.asset(
                      "assets/images/Icon.png",
                      width: 133,
                      height: 117,
                    ),
                    Text(
                      "Welcome, Please Login here",
                      style: kTextForTextBox.copyWith(
                        color: Color.fromRGBO(72, 40, 40, 0.698),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email input
                        Text("Email", style: kTextForTextBox),
                        SizedBox(height: 9),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            if (!value.contains("@gmail.com")) {
                              return "Invalid email format";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 21),

                        // Password input
                        Text("Password", style: kTextForTextBox),
                        SizedBox(height: 9),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          FlexibleButton(
                            name: "Login",
                            onTap: () async {
                              // Validate the form
                              if (_formKey.currentState!.validate()) {
                                // Form is valid, proceed with login
                                Map<String, dynamic> messageMap =
                                    await authViewModel.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                                if (!context.mounted) return;
                                if (messageMap['status']) {
                                  Navigator.pushReplacementNamed(
                                      context, 'dashboard');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(messageMap['message'])),
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'No account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: 'Register here',
                            style: TextStyle(
                              color: Color(0xFF7D59EE),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, "register");
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
