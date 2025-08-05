import 'package:fit_life/model/progress.dart';
import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/progress_viewModel.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class CreateProgressScreen extends StatefulWidget {
  final Map<String, dynamic> sessionData;
  CreateProgressScreen({super.key, required this.sessionData});

  @override
  State<CreateProgressScreen> createState() => _CreateProgressScreenState();
}

class _CreateProgressScreenState extends State<CreateProgressScreen> {
  final _setController = TextEditingController();

  final _repController = TextEditingController();

  final _weightController = TextEditingController();

  final _caloriesController = TextEditingController();

  final _distanceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.sessionData['progress']);

    _setController.text = widget.sessionData['progress']['set'];
    _repController.text = widget.sessionData['progress']['rep'];
    _weightController.text = widget.sessionData['progress']['weights'];
    _caloriesController.text = widget.sessionData['progress']['burnCalories'];
    _distanceController.text = widget.sessionData['progress']['distanceRun'];
  }

  @override
  Widget build(BuildContext context) {
    print("IN progress create page");
    print(widget.sessionData);
    final progressViewModel = Provider.of<ProgressViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Create progress"), centerTitle: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Progress",
                      style: kPageHeader.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primaryColor,
                      ),
                      children: [
                    TextSpan(
                      text: " For",
                      style: kPageHeader.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    )
                  ])),
              Text(
                "Mg Mg",
                style: kPageHeader.copyWith(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //Set input
                        Text("Set"),
                        SizedBox(width: 10),
                        Flexible(
                          child: TextFormField(
                            controller: _setController,
                            decoration: inputFieldDecoration,
                          ),
                        ),
                        SizedBox(width: 10),

                        //Rep input
                        Text("Rep"),
                        SizedBox(width: 10),
                        Flexible(
                          child: TextFormField(
                            controller: _repController,
                            decoration: inputFieldDecoration,
                          ),
                        ),
                        SizedBox(width: 10),

                        //Weight input
                        Text("Weight"),
                        SizedBox(width: 10),
                        Flexible(
                          child: TextFormField(
                            controller: _weightController,
                            decoration: inputFieldDecoration,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("Kg"),
                      ],
                    ),
                    //calories burn input
                    SizedBox(height: 13),
                    Text("Calories burn(kcal)"),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _caloriesController,
                      decoration: inputFieldDecoration,
                    ),

                    //Distance run input
                    SizedBox(height: 13),
                    Text("Distance run (km)"),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _distanceController,
                      decoration: inputFieldDecoration,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        FlexibleButton(
                            name: "Save",
                            onTap: () async {
                              print("HI");
                              if (_formKey.currentState!.validate()) {
                                ProgressModel progressData =
                                    ProgressModel.fromMap({
                                  'set': (_setController.text.isEmpty)
                                      ? "0"
                                      : _setController.text.trim(),
                                  'rep': (_repController.text.isEmpty)
                                      ? "0"
                                      : _repController.text.trim(),
                                  'weights': (_weightController.text.isEmpty)
                                      ? "0"
                                      : _weightController.text.trim(),
                                  'burnCalories':
                                      (_caloriesController.text.isEmpty)
                                          ? "0"
                                          : _caloriesController.text.trim(),
                                  'distanceRun':
                                      (_distanceController.text.isEmpty)
                                          ? "0"
                                          : _distanceController.text.trim(),
                                });
                                final sessionViewModel =
                                    Provider.of<SessionViewModel>(context,
                                        listen: false);
                                await progressViewModel.addProgress(
                                  widget.sessionData,
                                  progressData,
                                  sessionViewModel,
                                );

                                Navigator.pop(context);
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
