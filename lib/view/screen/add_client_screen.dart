import 'package:fit_life/model/client.dart';
import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/client_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final clientViewModel = Provider.of<ClientViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Add Client"), centerTitle: false),
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
                Text("Welcome a new ",
                    style: kPageHeader.copyWith(fontWeight: FontWeight.w900)),
                Text(
                  "Client",
                  style: kPageHeader.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name", style: kTextForTextBox),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) => value == null || value.isEmpty
                            ? "Please fill up name field"
                            : null,
                        decoration: inputFieldDecoration,
                      ),
                      SizedBox(height: 12),
                      Text("Email", style: kTextForTextBox),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) => value == null || value.isEmpty
                            ? "Please fill up name field"
                            : null,
                        decoration: inputFieldDecoration,
                      ),
                      SizedBox(height: 12),
                      Text("Phone", style: kTextForTextBox),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _phoneController,
                        validator: (value) => value == null || value.isEmpty
                            ? "Please fill up name field"
                            : null,
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
                  name: "Create",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      print("starting to create a client factory");
                      ClientModel client = ClientModel.fromMap({
                        "cid": "late",
                        "name": _nameController.text,
                        "email": _emailController.text,
                        "phone": _phoneController.text,
                        "createdDate": DateTime.now(),
                      });

                      await clientViewModel.createClient(client);

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
