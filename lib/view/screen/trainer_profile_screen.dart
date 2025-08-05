import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/screen/edit_trainerInfo_screen.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/auth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final user = authViewModel.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: kFont20.copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: [
                Icon(Icons.edit),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTrainerinfoScreen(
                          user: user,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Edit",
                    style: kRegularFont.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    "assets/images/trainer-image.png"), // Replace with your image path
              ),
              const SizedBox(height: 15),

              // Name
              Text(
                user!.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // Title
              Text(
                user.specialization,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Information Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email,
                            color: AppTheme.primaryColor),
                        title: Text(user.email),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.phone,
                          color: AppTheme.primaryColor,
                        ),
                        title: Text(user.phone ?? "no phone"),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              IconButton(
                onPressed: () async {
                  await authViewModel.logout();
                  Navigator.pushReplacementNamed(context, "login");
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
