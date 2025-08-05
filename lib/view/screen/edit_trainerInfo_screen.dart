import 'package:fit_life/model/user.dart';
import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/auth_viewModel.dart';
import 'package:fit_life/viewModel/trainer_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class EditTrainerinfoScreen extends StatefulWidget {
  final TrainerModel? user;
  const EditTrainerinfoScreen({super.key, required this.user});

  @override
  State<EditTrainerinfoScreen> createState() => _EditTrainerinfoScreenState();
}

class _EditTrainerinfoScreenState extends State<EditTrainerinfoScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _userNameController.text = widget.user!.name;
    _emailController.text = widget.user!.email;
    _specializationController.text = widget.user!.specialization;
    _phoneController.text = widget.user?.phone ?? "no phone";
  }

  @override
  Widget build(BuildContext context) {
    final trainerViewModel = Provider.of<TrainerViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Edit your info"), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Edit",
                    style: kPageHeader.copyWith(fontWeight: FontWeight.w900)),
                RichText(
                    text: TextSpan(
                        text: "Your",
                        style: kPageHeader.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppTheme.primaryColor,
                        ),
                        children: [
                      TextSpan(
                        text: " Info",
                        style: kPageHeader.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      )
                    ])),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name", style: kTextForTextBox),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) => value == null || value.isEmpty
                            ? "Please fill up this field"
                            : null,
                        decoration: inputFieldDecoration,
                      ),
                      SizedBox(height: 12),
                      Text("Specialization", style: kTextForTextBox),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _specializationController,
                        validator: (value) => value == null || value.isEmpty
                            ? "Please fill up this field"
                            : null,
                        decoration: inputFieldDecoration,
                      ),
                      SizedBox(height: 12),
                      Text("Email", style: kTextForTextBox),
                      SizedBox(height: 12),
                      TextFormField(
                        enabled: false,
                        controller: _emailController,
                        validator: (value) => value == null || value.isEmpty
                            ? "Please fill up this field"
                            : null,
                        decoration: inputFieldDecoration,
                      ),
                      SizedBox(height: 12),
                      Text("Phone", style: kTextForTextBox),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _phoneController,
                        decoration: inputFieldDecoration,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                FlexibleButton(
                  name: "Save",
                  onTap: () async {
                    TrainerModel? user;
                    final authViewModel =
                        Provider.of<AuthViewModel>(context, listen: false);
                    if (_formKey.currentState!.validate()) {
                      user = TrainerModel.fromMap({
                        'uid': widget.user!.uid,
                        'name': _userNameController.text,
                        'email': _emailController.text,
                        'specialization': _specializationController.text,
                        'phone': _phoneController.text,
                      });

                      bool isEditSuccess = await trainerViewModel.editUserInfo(
                          user, authViewModel);
                      isEditSuccess
                          ?
                          // ? Navigator.pushReplacementNamed(
                          //     context, 'userProfile')

                          Navigator.pop(context)
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Something's wrong! Please try again.")),
                            );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
