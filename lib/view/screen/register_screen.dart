import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/viewModel/auth_viewModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 90, bottom: 20, left: 40, right: 40),
          child: Center(
            child: Column(
              children: [
                Text(
                  "FITLIFE",
                  style: kTitleStyle.copyWith(fontSize: 40),
                ),
                Image.asset(
                  "assets/images/Icon.png",
                  width: 200,
                  height: 117,
                ),
                Text(
                  "Create an account",
                  style: kTextForTextBox.copyWith(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 14),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //User name input
                      Text("User name", style: kTextForTextBox),
                      SizedBox(height: 9),
                      TextFormField(
                        controller: _userNameController,
                        decoration: inputFieldDecoration,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your user name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 21),

                      //Specialization input
                      Text("Specialization", style: kTextForTextBox),
                      SizedBox(height: 9),
                      TextFormField(
                        controller: _specializationController,
                        decoration: inputFieldDecoration,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your user name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 21),

                      //Email input
                      Text("Email", style: kTextForTextBox),
                      SizedBox(height: 9),
                      TextFormField(
                        controller: _emailController,
                        decoration: inputFieldDecoration,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }

                          if (!value.contains("@gmail.com")) {
                            return "Invalid email format";
                          }
                          return null;
                        },
                      ),

                      //Password input
                      SizedBox(height: 21),
                      Text("Password", style: kTextForTextBox),
                      SizedBox(height: 9),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: inputFieldDecoration,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      //Confirm password
                      SizedBox(height: 21),
                      Text("Confirm Password", style: kTextForTextBox),
                      SizedBox(height: 9),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: inputFieldDecoration,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 33),
                      Row(
                        children: [
                          FlexibleButton(
                              name: "Register",
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  bool success = await authViewModel.signup(
                                      _userNameController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                      _specializationController.text);

                                  if (success) {
                                    Navigator.pushNamed(context, "login");
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("registeration Failed")),
                                    );
                                  }
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login here',
                        style: TextStyle(
                          color: Color(0xFF7D59EE),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "login");
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
    );
  }
}
