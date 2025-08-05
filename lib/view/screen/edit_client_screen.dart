import 'package:fit_life/model/client.dart';
import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/client_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class EditClientScreen extends StatefulWidget {
  final ClientModel client;
  const EditClientScreen({super.key, required this.client});

  @override
  State<EditClientScreen> createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nameController.text = widget.client.name;
    _phoneController.text = widget.client.phone;
    _emailController.text = widget.client.email;
  }

  @override
  Widget build(BuildContext context) {
    final clientViewModel = Provider.of<ClientViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Client"), centerTitle: false),
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
                        text: "Client",
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
                  name: "Save",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await clientViewModel.updateClient(ClientModel.fromMap({
                        'cid': widget.client.cid,
                        'name': _nameController.text,
                        'email': _emailController.text,
                        'phone': _phoneController.text,
                        'createdDate': widget.client.createdDate,
                      }));
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
